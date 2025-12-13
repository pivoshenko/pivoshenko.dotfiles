"""Tool that manages updates of themes for various applications."""

from __future__ import annotations

import sys
import logging

from typing import TYPE_CHECKING

import bat
import k9s
import zen
import fish
import yazi
import delta
import bottom
import stylus
import ghostty
import lazygit


if TYPE_CHECKING:
    import abstract


logging.basicConfig(
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
    format=(
        "%(asctime)s.%(msecs)03d | %(levelname)-8s | %(name)s:%(funcName)s:%(lineno)d - %(message)s"
    ),
)
logging.getLogger("httpx").setLevel(logging.WARNING)
logger = logging.getLogger(__name__)


class UpdateManager:
    def __init__(self) -> None:
        self.tools: list[abstract.Tool] = []

    def register(self, tool: abstract.Tool) -> None:
        self.tools.append(tool)

    def update(self) -> None:
        for tool in self.tools:
            tool.logger.info("Updating %s", tool.name)
            try:
                tool.update()
            except Exception:
                tool.logger.exception("Failed to update %s", tool.name)
            else:
                tool.logger.info("Successfully updated %s", tool.name)


def main() -> int:
    manager = UpdateManager()
    manager.register(bat.Bat())
    manager.register(bottom.Bottom())
    manager.register(delta.Delta())
    manager.register(fish.Fish())
    manager.register(ghostty.Ghostty())
    manager.register(k9s.K9s())
    manager.register(lazygit.Lazygit())
    manager.register(stylus.Stylus())
    manager.register(yazi.Yazi())
    manager.register(zen.Zen())
    manager.update()

    return 0


if __name__ == "__main__":
    sys.exit(main())
