"""Module that contains the IPython profile configuration for vi-mode editing and cursor shape."""

import sys

from prompt_toolkit.key_binding.vi_state import (  # ty: ignore[unresolved-import]
    InputMode,
    ViState,
)


def get_input_mode(self):
    return self._input_mode


def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 1, InputMode.REPLACE: 3}.get(mode, 5)
    raw = f"\x1b[{shape} q"
    if hasattr(sys.stdout, "_cli"):
        out = sys.stdout._cli.output.write_raw  # type: ignore[attr-defined]  # ty: ignore[unresolved-attribute]
    else:
        out = sys.stdout.write
    out(raw)
    sys.stdout.flush()
    self._input_mode = mode


ViState._input_mode = InputMode.INSERT  # type: ignore[attr-defined]
ViState.input_mode = property(get_input_mode, set_input_mode)  # type: ignore[method-assign, assignment]

c.TerminalInteractiveShell.editing_mode = "vi"  # noqa: F821  # ty: ignore[unresolved-reference]
c.TerminalInteractiveShell.true_color = True  # noqa: F821  # ty: ignore[unresolved-reference]
