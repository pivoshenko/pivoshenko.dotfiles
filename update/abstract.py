from __future__ import annotations

import abc
import logging
import dataclasses

from typing import TYPE_CHECKING


if TYPE_CHECKING:
    import pathlib


@dataclasses.dataclass
class Tool(abc.ABC):
    name: str

    extension: str

    source: str
    destination: pathlib.Path

    def __post_init__(self) -> None:
        self.logger = logging.getLogger(__name__)
        self.prefix: str = "catppuccin"

    @abc.abstractmethod
    def update(self) -> None:
        pass
