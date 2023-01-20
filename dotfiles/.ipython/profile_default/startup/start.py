"""IPython - startup script."""

from IPython import get_ipython

ipython = get_ipython()

if "ipython" in globals():  # noqa: WPS421, Q000
    ipython.editing_mode = "vi"  # noqa: Q000
    ipython.run_line_magic("load_ext", "autoreload")  # noqa: Q000
    ipython.run_line_magic("autoreload", "2")  # noqa: Q000

from pprint import pprint  # noqa: F401, E402
