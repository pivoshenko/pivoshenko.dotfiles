"""Module that contains the IPython startup script that enables autoreload."""

from __future__ import annotations

from IPython import get_ipython  # ty: ignore[unresolved-import]  # type: ignore[attr-defined]


ipython = get_ipython()

if ipython is not None:
    ipython.run_line_magic("load_ext", "autoreload")  # type: ignore[attr-defined]
    ipython.run_line_magic("autoreload", "2")  # type: ignore[attr-defined]
