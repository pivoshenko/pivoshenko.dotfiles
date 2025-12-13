"""Script that responsible for switching themes across applications based on a system mode."""

from __future__ import annotations

import abc
import sys
import logging
import pathlib
import subprocess
import dataclasses


logging.basicConfig(
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
    format=(
        "%(asctime)s.%(msecs)03d | %(levelname)-8s | %(name)s:%(funcName)s:%(lineno)d - %(message)s"
    ),
)
logger = logging.getLogger(__name__)


@dataclasses.dataclass
class Tool(abc.ABC):
    name: str

    dark_theme: str
    light_theme: str

    filepath: pathlib.Path

    @abc.abstractmethod
    def switch(self, *, is_dark: bool) -> None:
        pass

    def get_theme(self, *, is_dark: bool) -> str:
        if is_dark:
            return self.dark_theme
        return self.light_theme

    def execute(self, commands: str) -> None:
        for command in commands:
            subprocess.run(command, shell=True, check=True, capture_output=True, text=True)  # noqa: S602


@dataclasses.dataclass
class Bat(Tool):
    name: str = "Bat"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "bat" / "config"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            if line.strip().startswith("--theme="):
                updated_config += f'--theme="{theme}"\n'
            else:
                updated_config += line

        self.filepath.write_text(updated_config)
        self.execute(["bat cache --build"])


@dataclasses.dataclass
class Bottom(Tool):
    name: str = "Bottom"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "bottom" / "bottom.toml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        theme_file = self.filepath.parent / "themes" / f"{theme}.toml"
        theme_content = theme_file.read_text()

        current_config = self.filepath.read_text()
        lines = current_config.splitlines(keepends=True)
        updated_config = ""
        in_styles_section = False

        for line in lines:
            stripped = line.strip()
            if stripped.startswith("[styles."):
                in_styles_section = True
                continue
            if in_styles_section:
                if stripped.startswith("[") and not stripped.startswith("[styles."):
                    in_styles_section = False
                    updated_config += line
                continue
            updated_config += line

        if updated_config and not updated_config.endswith("\n\n"):
            updated_config = updated_config.rstrip() + "\n\n"

        updated_config += theme_content

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class DBeaver(Tool):
    name: str = "DBeaver"

    dark_theme: str = "org.eclipse.e4.ui.css.theme.e4_dark"
    light_theme: str = "org.eclipse.e4.ui.css.theme.e4_default"

    filepath: pathlib.Path = (
        pathlib.Path.home()
        / "Library"
        / "DBeaverData"
        / "workspace6"
        / ".metadata"
        / ".plugins"
        / "org.eclipse.core.runtime"
        / ".settings"
        / "org.eclipse.e4.ui.css.swt.theme.prefs"
    )

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        self.filepath.parent.mkdir(parents=True, exist_ok=True)

        content = f"eclipse.preferences.version=1\nthemeid={theme}\n"
        self.filepath.write_text(content)


@dataclasses.dataclass
class Delta(Tool):
    name: str = "Delta"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".gitconfig"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        in_delta_section = False
        for line in current_config.splitlines(keepends=True):
            stripped = line.strip()

            if stripped == "[delta]":
                in_delta_section = True
                updated_config += line
            elif in_delta_section and stripped.startswith("["):
                in_delta_section = False
                updated_config += line
            elif in_delta_section and stripped.startswith("features ="):
                indent = len(line) - len(line.lstrip())
                updated_config += f'{" " * indent}features = "{theme}"\n'
            elif in_delta_section and stripped.startswith("light ="):
                indent = len(line) - len(line.lstrip())
                updated_config += f"{' ' * indent}light = {str(not is_dark).lower()}\n"
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Fastfetch(Tool):
    name: str = "Fastfetch"

    dark_theme: str = "38;2;137;180;250"  # Catppuccin Mocha blue
    light_theme: str = "38;2;30;102;245"  # Catppuccin Latte blue

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "fastfetch" / "config.jsonc"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = current_config

        colors = [
            "38;2;30;102;245",  # Latte
            "38;2;140;170;238",  # Frappe
            "38;2;138;173;244",  # Macchiato
            "38;2;137;180;250",  # Mocha
        ]

        for color in colors:
            updated_config = updated_config.replace(color, theme)

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Fish(Tool):
    name: str = "Fish"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "fish" / "config.fish"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        self.execute([f'echo y | fish -c "fish_config theme save \\"{theme}\\""'])


@dataclasses.dataclass
class Fzf(Tool):
    name: str = "Fzf"

    dark_theme: str = "FZF_CATPPUCCIN_MOCHA"
    light_theme: str = "FZF_CATPPUCCIN_LATTE"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "fish" / "fzf.fish"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            if line.strip().startswith("set -Ux FZF_THEME"):
                updated_config += f"set -Ux FZF_THEME ${theme}\n"
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Ghostty(Tool):
    name: str = "Ghostty"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "ghostty" / "config"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            if line.strip().startswith("theme ="):
                updated_config += f"theme = {theme}.conf\n"
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Helix(Tool):
    name: str = "Helix"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "helix" / "config.toml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            if line.strip().startswith("theme ="):
                updated_config += f'theme = "{theme}"\n'
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class K9s(Tool):
    name: str = "K9s"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "k9s" / "config.yaml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            stripped = line.strip()
            if stripped.startswith("skin:"):
                indent = len(line) - len(line.lstrip())
                updated_config += f"{' ' * indent}skin: {theme}\n"
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Lazygit(Tool):
    name: str = "Lazygit"

    dark_theme: str = "catppuccin_mocha_blue"
    light_theme: str = "catppuccin_latte_blue"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "lazygit" / "config.yml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        theme_file = self.filepath.parent / "themes" / f"{theme}.yml"

        theme_content = theme_file.read_text()
        current_config = self.filepath.read_text()

        updated_config = self._remove_gui_sections(current_config)

        if "gui:" not in updated_config:
            updated_config = self._add_gui_section(updated_config)

        updated_config = self._add_theme_content(updated_config, theme_content)

        self.filepath.write_text(updated_config)

    def _remove_gui_sections(self, config: str) -> str:
        lines = config.splitlines(keepends=True)
        result = ""
        skip_lines = False
        in_gui = False

        for line in lines:
            stripped = line.strip()

            if stripped == "gui:":
                in_gui = True
                result += line
                continue

            if in_gui:
                if stripped.startswith(("theme:", "authorColors:")):
                    skip_lines = True
                    continue
                is_top_level = line and not line[0].isspace()
                if is_top_level and not stripped.startswith("#"):
                    in_gui = False
                    skip_lines = False
                if skip_lines and line and not line[0].isspace():
                    skip_lines = False

            if not skip_lines:
                result += line

        return result

    def _add_gui_section(self, config: str) -> str:
        if config and not config.endswith("\n\n"):
            config = config.rstrip() + "\n\n"
        return config + "gui:\n"

    def _add_theme_content(self, config: str, theme_content: str) -> str:
        indented_theme = ""
        for line in theme_content.splitlines(keepends=True):
            if line.strip() == "":
                indented_theme += line
            else:
                indented_theme += f"  {line}"

        if config.endswith("\n"):
            config = config.rstrip("\n") + "\n" + indented_theme
            if not config.endswith("\n"):
                config += "\n"
        else:
            config += "\n" + indented_theme

        return config


@dataclasses.dataclass
class Starship(Tool):
    name: str = "Starship"

    dark_theme: str = "catppuccin_mocha"
    light_theme: str = "catppuccin_latte"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "starship.toml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            if line.strip().startswith("palette ="):
                updated_config += f'palette = "{theme}"\n'
            else:
                updated_config += line

        self.filepath.write_text(updated_config)


@dataclasses.dataclass
class Yazi(Tool):
    name: str = "Yazi"

    dark_theme: str = "catppuccin_mocha_blue"
    light_theme: str = "catppuccin_latte_blue"

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "yazi" / "theme.toml"

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)
        theme_file = self.filepath.parent / "themes" / f"{theme}.toml"

        theme_content = theme_file.read_text()
        self.filepath.write_text(theme_content)


@dataclasses.dataclass
class Zellij(Tool):
    name: str = "Zellij"

    dark_theme: str = "catppuccin-mocha"
    light_theme: str = "catppuccin-latte"

    dark_colors: dict[str, str] = dataclasses.field(
        default_factory=lambda: {
            "text": "#cdd6f4",
            "mantle": "#181825",
            "blue": "#89b4fa",
            "mauve": "#cba6f7",
            "peach": "#fab387",
        },
    )
    light_colors: dict[str, str] = dataclasses.field(
        default_factory=lambda: {
            "text": "#4c4f69",
            "mantle": "#e6e9ef",
            "blue": "#1e66f5",
            "mauve": "#8839ef",
            "peach": "#fe640b",
        },
    )

    filepath: pathlib.Path = pathlib.Path.home() / ".config" / "zellij" / "config.kdl"
    layout_filepath: pathlib.Path = (
        pathlib.Path.home() / ".config" / "zellij" / "layouts" / "default.kdl"
    )

    def switch(self, *, is_dark: bool) -> None:
        theme = self.get_theme(is_dark=is_dark)

        current_config = self.filepath.read_text()
        updated_config = ""

        for line in current_config.splitlines(keepends=True):
            stripped = line.strip()
            if stripped.startswith("theme "):
                indent = len(line) - len(line.lstrip())
                updated_config += f'{" " * indent}theme "{theme}"\n'
            else:
                updated_config += line

        self.filepath.write_text(updated_config)

        self._switch_layout_colors(is_dark=is_dark)

    def _switch_layout_colors(self, *, is_dark: bool) -> None:
        colors = self.dark_colors if is_dark else self.light_colors
        opposite_colors = self.light_colors if is_dark else self.dark_colors

        current_layout = self.layout_filepath.read_text()
        updated_layout = current_layout

        for color_name, new_value in colors.items():
            old_value = opposite_colors[color_name]
            updated_layout = updated_layout.replace(old_value, new_value)

        self.layout_filepath.write_text(updated_layout)


class ThemeManager:
    def __init__(self) -> None:
        self.switchers: list[Tool] = []

    def register(self, switcher: Tool) -> None:
        self.switchers.append(switcher)

    def switch(self, *, is_dark: bool) -> None:
        for switcher in self.switchers:
            logger.info(
                "Switching %s theme to %s",
                switcher.name,
                switcher.get_theme(is_dark=is_dark),
            )
            try:
                switcher.switch(is_dark=is_dark)
            except Exception:
                logger.exception("Failed to switch %s theme", switcher.name)
            else:
                logger.info("Successfully switched %s theme", switcher.name)


def main() -> int:
    is_dark = sys.argv[1] == "dark"

    manager = ThemeManager()
    manager.register(Bat())
    manager.register(Bottom())
    manager.register(DBeaver())
    manager.register(Delta())
    manager.register(Fastfetch())
    manager.register(Fish())
    manager.register(Fzf())
    manager.register(Helix())
    manager.register(K9s())
    manager.register(Lazygit())
    manager.register(Starship())
    manager.register(Yazi())
    manager.register(Zellij())
    manager.switch(is_dark=is_dark)

    return 0


if __name__ == "__main__":
    sys.exit(main())
