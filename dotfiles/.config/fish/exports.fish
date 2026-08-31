set -Ux XDG_CONFIG_HOME $HOME/.config

set -Ux EDITOR hx
set -Ux VISUAL $EDITOR

set -Ux GPG_TTY (tty)

set -Ux HOMEBREW_NO_ANALYTICS 1

set -Ux PYTHONBREAKPOINT IPython.terminal.debugger.set_trace

# == Path ==
fish_add_path -g $HOME/.docker/bin
