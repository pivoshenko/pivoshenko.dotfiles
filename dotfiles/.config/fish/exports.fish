# set default config home directory
set -gx XDG_CONFIG_HOME $HOME/.config

# =================================================
# Shell
# =================================================

# set default editor
set -gx EDITOR hx
# set visual editor to the same as default editor
set -gx VISUAL $EDITOR

# get the current terminal and set it for GPG
set -gx GPG_TTY (tty)

# =================================================
# Package managers
# =================================================

# disable statistics that `brew` collects
set -gx HOMEBREW_NO_ANALYTICS 1

# =================================================
# REPLs
# =================================================

# set `IPython` as the default Python debugger
set -gx PYTHONBREAKPOINT IPython.terminal.debugger.set_trace

# =================================================
# Misc
# =================================================

# add `spicetify` to `PATH`
set -gx PATH $PATH $HOME/.spicetify
