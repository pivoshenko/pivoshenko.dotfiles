from IPython import get_ipython  # type: ignore[attr-defined]

ipython = get_ipython()

if "ipython" in globals():
    ipython.editing_mode = "vi"  # type: ignore[attr-defined]

    # Autoreload modules/packages after their modification
    ipython.run_line_magic("load_ext", "autoreload")  # type: ignore[attr-defined]
    ipython.run_line_magic("autoreload", "2")  # type: ignore[attr-defined]
