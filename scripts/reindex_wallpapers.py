"""Reindex image files in subdirectories of the `wallpapers` directory.

This script renames all .png, .jpg, and .jpeg files in each subdirectory of the
'wallpapers' directory to a consistent format: `{subdir_name}_{index}{extension}`.

Steps:
1. Temporarily rename files to avoid conflicts.
2. Rename files to the final format.

Example:
    wallpapers/
        logo/
            asdaseygas.jpg -> logo_0.jpg
"""

from __future__ import annotations

from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

import logging

BASEPATH = Path.cwd() / "dotfiles" / ".config" / "wallpapers"


def reindex_files_in_subdir(subdir: Path) -> None:
    logging.info(f"Reindexing files in {subdir.name}")
    for index, filepath in enumerate(subdir.glob("*.*")):
        f_index = str(index)
        f_index = f"0{f_index}" if len(f_index) == 1 else f_index

        if filepath.suffix in (".png", ".jpg", ".jpeg"):
            filepath.rename(
                filepath.with_name(f"tmp_{f_index}{filepath.suffix.lower()}")
            )

    for index, filepath in enumerate(subdir.glob("*.*")):
        f_index = str(index)
        f_index = f"0{f_index}" if len(f_index) == 1 else f_index

        if filepath.suffix in (".png", ".jpg", ".jpeg"):
            filepath.rename(
                filepath.with_name(f"{subdir.name}_{f_index}{filepath.suffix.lower()}")
            )


if __name__ == "__main__":
    with ThreadPoolExecutor() as executor:
        futures = [
            executor.submit(reindex_files_in_subdir, subdir)
            for subdir in BASEPATH.iterdir()
            if subdir.is_dir()
        ]
        for future in futures:
            future.result()
