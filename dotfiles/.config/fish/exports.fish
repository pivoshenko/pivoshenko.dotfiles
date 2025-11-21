set -Ux XDG_CONFIG_HOME $HOME/.config

set -Ux EDITOR hx
set -Ux VISUAL $EDITOR

set -Ux GPG_TTY (tty)

# == External tools ==
set -Ux HOMEBREW_NO_ANALYTICS 1
set -Ux PATH $PATH $HOME/.spicetify
set -Ux PYTHONBREAKPOINT IPython.terminal.debugger.set_trace
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
