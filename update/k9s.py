from __future__ import annotations

import pathlib
import dataclasses

import utils
import abstract


@dataclasses.dataclass
class K9s(abstract.Tool):
    name: str = "K9s"

    extension: str = ".yaml"

    source: str = "https://api.github.com/repos/catppuccin/k9s/contents/dist"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "k9s" / "skins"
    )

    def update(self) -> None:
        utils.download(
            source=self.source,
            destination=self.destination,
            extension=self.extension,
            prefix=self.prefix,
        )
