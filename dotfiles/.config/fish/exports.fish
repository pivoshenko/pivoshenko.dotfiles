# Set default config home directory
set -Ux XDG_CONFIG_HOME $HOME/.config

# =================================================
# Shell
# =================================================

# Set default editor
set -Ux EDITOR hx
# Set visual editor to the same as default editor
set -Ux VISUAL $EDITOR

# Get the current terminal and set it for GPG
set -Ux GPG_TTY (tty)

# =================================================
# Package managers
# =================================================

# Disable statistics that `brew` collects
set -Ux HOMEBREW_NO_ANALYTICS 1

# =================================================
# REPLs
# =================================================

# Set `IPython` as the default Python debugger
set -Ux PYTHONBREAKPOINT IPython.terminal.debugger.set_trace

# =================================================
# Misc
# =================================================

# Add `spicetify` to `PATH`
set -Ux PATH $PATH $HOME/.spicetify
