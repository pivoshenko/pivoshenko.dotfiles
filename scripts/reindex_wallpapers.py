"""Reindex wallpapers."""

from __future__ import annotations

from pathlib import Path


basepath = Path.cwd() / "wallpapers"


if __name__ == "__main__":
    for subdir in basepath.iterdir():
        for index, filepath in enumerate(subdir.glob("*.*")):
            if filepath.suffix in (".png", ".jpg", ".jpeg"):
                filepath.rename(filepath.with_name(f"tmp_{index}{filepath.suffix.lower()}"))

        for index, filepath in enumerate(subdir.glob("*.*")):
            if filepath.suffix in (".png", ".jpg", ".jpeg"):
                filepath.rename(filepath.with_name(f"{subdir.name}_{index}{filepath.suffix.lower()}"))
