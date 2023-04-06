"""IPython - startup script."""

from IPython import get_ipython  # type: ignore

ipython = get_ipython()

if "ipython" in globals():  # noqa: WPS421, Q000
    ipython.editing_mode = "vi"  # noqa: Q000  # type: ignore
    ipython.run_line_magic("load_ext", "autoreload")  # noqa: Q000 E501  # type: ignore
    ipython.run_line_magic("autoreload", "2")  # noqa: Q000  # type: ignore

from pprint import pprint  # noqa: F401, E402
