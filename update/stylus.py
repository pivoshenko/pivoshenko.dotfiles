from __future__ import annotations

import pathlib
import dataclasses

import httpx
import abstract


@dataclasses.dataclass
class Stylus(abstract.Tool):
    name: str = "Stylus"

    extension: str = ".json"

    source: str = "https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "stylus"
    )

    def update(self) -> None:
        self.destination.mkdir(parents=True, exist_ok=True)

        response: httpx.Response = httpx.get(self.source, follow_redirects=True)
        response.raise_for_status()

        destination_file: pathlib.Path = self.destination / f"{self.prefix}{self.extension}"
        destination_file.write_text(response.text)
