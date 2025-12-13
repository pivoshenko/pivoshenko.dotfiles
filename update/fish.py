from __future__ import annotations

import pathlib
import dataclasses

import utils
import abstract


@dataclasses.dataclass
class Fish(abstract.Tool):
    name: str = "Fish"

    extension: str = ".theme"

    source: str = "https://api.github.com/repos/catppuccin/fish/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "fish" / "themes"
    )

    def update(self) -> None:
        utils.download(
            source=self.source,
            destination=self.destination,
            extension=self.extension,
            prefix=self.prefix,
        )
