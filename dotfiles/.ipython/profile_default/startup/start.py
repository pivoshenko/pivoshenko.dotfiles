"""IPython - startup script."""

from IPython import get_ipython

ipython = get_ipython()

if "ipython" in globals():

    # keybindings
    ipython.editing_mode = "vi"

    # autoreload modules/packages after their modification
    ipython.run_line_magic("load_ext", "autoreload")
    ipython.run_line_magic("autoreload", "2")
