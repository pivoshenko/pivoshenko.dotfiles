from __future__ import annotations

import pathlib
import dataclasses

import utils
import abstract


@dataclasses.dataclass
class Bottom(abstract.Tool):
    name: str = "Bottom"

    extension: str = ".toml"

    source: str = "https://api.github.com/repos/catppuccin/bottom/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "bottom" / "themes"
    )

    def update(self) -> None:
        utils.download(
            source=self.source,
            destination=self.destination,
            extension=self.extension,
            prefix=self.prefix,
        )
