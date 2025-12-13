from __future__ import annotations

import pathlib
import dataclasses

import httpx
import abstract


@dataclasses.dataclass
class Yazi(abstract.Tool):
    name: str = "Yazi"

    extension: str = ".toml"

    source: str = "https://api.github.com/repos/catppuccin/yazi/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "yazi" / "themes"
    )

    def update(self) -> None:
        self.destination.mkdir(parents=True, exist_ok=True)

        response: httpx.Response = httpx.get(self.source)
        response.raise_for_status()

        directories: list[dict] = response.json()
        theme_dirs: list[dict] = [dr for dr in directories if dr["type"] == "dir"]

        for theme_dir in theme_dirs:
            flavor_name: str = theme_dir["name"]
            flavor_url: str = theme_dir["url"]

            flavor_response: httpx.Response = httpx.get(flavor_url)
            flavor_response.raise_for_status()

            files: list[dict] = flavor_response.json()
            theme_files: list[dict] = [
                file for file in files if file["name"].endswith(self.extension)
            ]

            for file_info in theme_files:
                filename: str = file_info["name"]
                download_url: str = file_info["download_url"]

                color_name: str = filename.replace(self.extension, "").split("-")[-1]
                prefixed_filename: str = f"{self.prefix}_{flavor_name}_{color_name}{self.extension}"
                destination_file: pathlib.Path = self.destination / prefixed_filename

                file_response: httpx.Response = httpx.get(download_url)
                file_response.raise_for_status()

                destination_file.write_text(file_response.text)
