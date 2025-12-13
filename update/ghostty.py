from __future__ import annotations

import pathlib
import dataclasses

import utils
import abstract


@dataclasses.dataclass
class Ghostty(abstract.Tool):
    name: str = "Ghostty"

    extension: str = ".conf"

    source: str = "https://api.github.com/repos/catppuccin/ghostty/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "ghostty" / "themes"
    )

    def update(self) -> None:
        utils.download(
            source=self.source,
            destination=self.destination,
            extension=self.extension,
            prefix=self.prefix,
        )
