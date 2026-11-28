"""Tests for the IPython profile config and startup script."""

from __future__ import annotations

import runpy

from pathlib import Path
from types import SimpleNamespace

import pytest

from prompt_toolkit.key_binding.vi_state import InputMode
from prompt_toolkit.key_binding.vi_state import ViState


PROFILE = Path(__file__).parent.parent / "dotfiles" / ".ipython" / "profile_default"


@pytest.fixture
def config(monkeypatch: pytest.MonkeyPatch) -> SimpleNamespace:
    # The config patches ViState at class level, so register the attributes for restoration
    monkeypatch.setattr(ViState, "_input_mode", InputMode.INSERT, raising=False)
    monkeypatch.setattr(ViState, "input_mode", None, raising=False)
    c = SimpleNamespace(TerminalInteractiveShell=SimpleNamespace())
    runpy.run_path(str(PROFILE / "ipython_config.py"), init_globals={"c": c})
    return c


def test_config_enables_vi_mode_and_true_color(config: SimpleNamespace) -> None:
    assert config.TerminalInteractiveShell.editing_mode == "vi"
    assert config.TerminalInteractiveShell.true_color is True


@pytest.mark.parametrize(
    ("mode", "shape"),
    [(InputMode.NAVIGATION, 1), (InputMode.REPLACE, 3), (InputMode.INSERT, 5)],
)
def test_input_mode_emits_cursor_shape(
    config: SimpleNamespace,  # noqa: ARG001
    capsys: pytest.CaptureFixture[str],
    mode: InputMode,
    shape: int,
) -> None:
    state = ViState()
    state.input_mode = mode

    assert capsys.readouterr().out == f"\x1b[{shape} q"
    assert state.input_mode == mode


def test_startup_loads_autoreload(monkeypatch: pytest.MonkeyPatch) -> None:
    calls: list[tuple[str, str]] = []
    shell = SimpleNamespace(run_line_magic=lambda name, arg: calls.append((name, arg)))
    monkeypatch.setattr("IPython.get_ipython", lambda: shell)

    runpy.run_path(str(PROFILE / "startup" / "start.py"))

    assert calls == [("load_ext", "autoreload"), ("autoreload", "2")]


def test_startup_is_noop_outside_ipython(monkeypatch: pytest.MonkeyPatch) -> None:
    monkeypatch.setattr("IPython.get_ipython", lambda: None)

    runpy.run_path(str(PROFILE / "startup" / "start.py"))
