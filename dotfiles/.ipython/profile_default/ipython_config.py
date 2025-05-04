import sys

from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.vi_state import ViState


def get_input_mode(self):
    return self._input_mode


def set_input_mode(self, mode):
    shape = {InputMode.NAVIGATION: 1, InputMode.REPLACE: 3}.get(mode, 5)
    raw = "\x1b[{} q".format(shape)
    if hasattr(sys.stdout, "_cli"):
        out = sys.stdout._cli.output.write_raw  # type: ignore[attr-defined]
    else:
        out = sys.stdout.write
    out(raw)
    sys.stdout.flush()
    self._input_mode = mode


# enable `vi` mode
ViState._input_mode = InputMode.INSERT  # type: ignore[attr-defined]
ViState.input_mode = property(get_input_mode, set_input_mode)  # type: ignore[method-assign, assignment]
c.TerminalInteractiveShell.editing_mode = "vi"  # type: ignore[name-defined]  # noqa: F821

# set custom theme
c.TerminalInteractiveShell.true_color = True  # type: ignore[attr-defined]  # noqa: F821
c.TerminalInteractiveShell.highlighting_style = "catppuccin-mocha"  # type: ignore[attr-defined]  # noqa: F821
