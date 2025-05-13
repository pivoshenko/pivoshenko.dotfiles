# set default config home directory
set -Ux XDG_CONFIG_HOME $HOME/.config

# =================================================
# Shell
# =================================================

# set default editor
set -Ux EDITOR hx
# set visual editor to the same as default editor
set -Ux VISUAL $EDITOR

# get the current terminal and set it for GPG
set -Ux GPG_TTY (tty)

# =================================================
# Package managers
# =================================================

# disable statistics that `brew` collects
set -Ux HOMEBREW_NO_ANALYTICS 1

# =================================================
# REPLs
# =================================================

# set `IPython` as the default Python debugger
set -Ux PYTHONBREAKPOINT IPython.terminal.debugger.set_trace

# =================================================
# Misc
# =================================================

# add `spicetify` to `PATH`
set -Ux PATH $PATH $HOME/.spicetify
