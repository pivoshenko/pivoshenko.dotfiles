"""Module that contains the IPython startup script that enables autoreload."""

from IPython import (  # ty: ignore[unresolved-import]
    get_ipython,  # type: ignore[attr-defined]
)

ipython = get_ipython()

if ipython is not None:
    ipython.run_line_magic("load_ext", "autoreload")  # type: ignore[attr-defined]
    ipython.run_line_magic("autoreload", "2")  # type: ignore[attr-defined]
