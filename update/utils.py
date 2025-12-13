from __future__ import annotations

import re

from typing import TYPE_CHECKING

import httpx


if TYPE_CHECKING:
    import pathlib


def to_snake_case(filename: str, prefix: str = "") -> str:
    name_parts: list[str] = filename.rsplit(".", 1)
    name: str = name_parts[0]
    extension: str = f".{name_parts[1]}" if len(name_parts) > 1 else ""

    name = re.sub(r"[\s-]+", "_", name)
    name = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", name)

    match (prefix, prefix.lower() in name.lower() if prefix else True):
        case (prf, False) if prf:
            name = f"{prefix}_{name}"
        case _:
            pass

    return name.lower() + extension


def download(source: str, destination: pathlib.Path, extension: str, prefix: str) -> None:
    destination.mkdir(parents=True, exist_ok=True)

    response: httpx.Response = httpx.get(source)
    response.raise_for_status()

    files: list[dict] = response.json()
    theme_files: list[dict] = [file for file in files if file["name"].endswith(extension)]

    for file_info in theme_files:
        filename: str = file_info["name"]
        download_url: str = file_info["download_url"]
        snake_case_name: str = to_snake_case(filename, prefix=prefix)
        destination_file: pathlib.Path = destination / snake_case_name

        file_response: httpx.Response = httpx.get(download_url)
        file_response.raise_for_status()

        destination_file.write_text(file_response.text)
