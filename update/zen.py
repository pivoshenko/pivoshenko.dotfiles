from __future__ import annotations

import pathlib
import dataclasses

import httpx
import abstract


@dataclasses.dataclass
class Zen(abstract.Tool):
    name: str = "Zen"

    extension: str = ".css"

    source: str = "https://api.github.com/repos/catppuccin/zen-browser/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "zen"
    )

    light_flavor: str = "Latte"
    dark_flavors: list[str] = dataclasses.field(
        default_factory=lambda: ["Mocha", "Frappe", "Macchiato"],
    )

    def update(self) -> None:
        self.destination.mkdir(parents=True, exist_ok=True)

        light_flavor_url = f"{self.source}/{self.light_flavor}"
        response: httpx.Response = httpx.get(light_flavor_url)
        response.raise_for_status()

        accent_colors: list[dict] = response.json()

        for accent in accent_colors:
            if accent["type"] == "dir":
                accent_name = accent["name"]

                for dark_flavor in self.dark_flavors:
                    self._process_accent_color(accent_name, dark_flavor)

    def _process_accent_color(self, accent_name: str, dark_flavor: str) -> None:
        dir_name = f"{self.prefix}_{dark_flavor.lower()}_{accent_name.lower()}"
        accent_dir = self.destination / dir_name
        accent_dir.mkdir(parents=True, exist_ok=True)

        for css_file in ["userChrome.css", "userContent.css"]:
            self._combine_css_file(accent_name, css_file, accent_dir, dark_flavor)

    def _combine_css_file(
        self,
        accent_name: str,
        css_filename: str,
        output_dir: pathlib.Path,
        dark_flavor: str,
    ) -> None:
        light_url = f"https://raw.githubusercontent.com/catppuccin/zen-browser/main/themes/{self.light_flavor}/{accent_name}/{css_filename}"
        light_response: httpx.Response = httpx.get(light_url)
        light_response.raise_for_status()
        light_css = light_response.text

        dark_url = f"https://raw.githubusercontent.com/catppuccin/zen-browser/main/themes/{dark_flavor}/{accent_name}/{css_filename}"
        dark_response: httpx.Response = httpx.get(dark_url)
        dark_response.raise_for_status()
        dark_css = dark_response.text

        combined_css = self._merge_css_content(
            light_css,
            dark_css,
            accent_name,
            css_filename,
            dark_flavor,
        )

        output_file = output_dir / css_filename
        output_file.write_text(combined_css)

    def _merge_css_content(
        self,
        light_css: str,
        dark_css: str,
        accent_name: str,
        css_filename: str,
        dark_flavor: str,
    ) -> str:
        header = (
            f"/* Catppuccin {self.light_flavor} {accent_name} + "
            f"{dark_flavor} {accent_name} {css_filename}*/\n\n"
        )

        return header + light_css + "\n\n" + dark_css
