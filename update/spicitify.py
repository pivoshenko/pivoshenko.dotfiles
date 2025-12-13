from __future__ import annotations

import pathlib
import dataclasses

import httpx
import abstract


@dataclasses.dataclass
class Spicetify(abstract.Tool):
    name: str = "Spicetify"

    extension: str = ""

    source: str = "https://api.github.com/repos/catppuccin/spicetify/contents/catppuccin"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent
        / "dotfiles"
        / ".config"
        / "spicetify"
        / "Themes"
        / "catppuccin"
    )

    def update(self) -> None:
        self._download_directory(source=self.source, destination=self.destination)

    def _download_directory(self, source: str, destination: pathlib.Path) -> None:
        destination.mkdir(parents=True, exist_ok=True)

        response: httpx.Response = httpx.get(source)
        response.raise_for_status()

        items: list[dict] = response.json()

        for item in items:
            item_name: str = item["name"]
            item_type: str = item["type"]
            item_path: pathlib.Path = destination / item_name

            if item_type == "file":
                download_url: str = item["download_url"]
                file_response: httpx.Response = httpx.get(download_url)
                file_response.raise_for_status()

                item_path.write_text(file_response.text)

            elif item_type == "dir":
                item_url: str = item["url"]
                self._download_directory(source=item_url, destination=item_path)
