from __future__ import annotations

import pathlib
import dataclasses

import utils
import abstract


@dataclasses.dataclass
class Bat(abstract.Tool):
    name: str = "Bat"

    extension: str = ".tmTheme"

    source: str = "https://api.github.com/repos/catppuccin/bat/contents/themes"
    destination: pathlib.Path = (
        pathlib.Path(__file__).parent.parent / "dotfiles" / ".config" / "bat" / "themes"
    )

    def update(self) -> None:
        utils.download(
            source=self.source,
            destination=self.destination,
            extension=self.extension,
            prefix=self.prefix,
        )
