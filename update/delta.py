from __future__ import annotations

import pathlib
import dataclasses

import httpx
import abstract


@dataclasses.dataclass
class Delta(abstract.Tool):
    name: str = "Delta"

    extension: str = ".gitconfig"

    source: str = "https://raw.githubusercontent.com/catppuccin/delta/main/catppuccin.gitconfig"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent
        / "dotfiles"
        / ".config"
        / "delta"
        / "catppuccin.gitconfig"
    )

    def update(self) -> None:
        self.destination.parent.mkdir(parents=True, exist_ok=True)

        response: httpx.Response = httpx.get(self.source)
        response.raise_for_status()

        content: str = response.text

        content = content.replace('"catppuccin-latte"', '"catppuccin_latte"')
        content = content.replace("Catppuccin Latte", "catppuccin_latte")
        content = content.replace('"catppuccin-frappe"', '"catppuccin_frappe"')
        content = content.replace("Catppuccin Frappe", "catppuccin_frappe")
        content = content.replace('"catppuccin-macchiato"', '"catppuccin_macchiato"')
        content = content.replace("Catppuccin Macchiato", "catppuccin_macchiato")
        content = content.replace('"catppuccin-mocha"', '"catppuccin_mocha"')
        content = content.replace("Catppuccin Mocha", "catppuccin_mocha")

        self.destination.write_text(content)
