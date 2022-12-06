""""IPython - startup script."""

from IPython import get_ipython


ipython = get_ipython()

if "ipython" in globals():
    ipython.editing_mode = "vi"
    ipython.run_line_magic("load_ext", "autoreload")
    ipython.run_line_magic("autoreload", "2")

from pprint import pprint as print
