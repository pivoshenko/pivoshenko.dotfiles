# =================================================
# oh-my-zsh
# =================================================

# path to the `oh-my-zsh` installation
export ZSH="$HOME/.oh-my-zsh"

# override the default theme
ZSH_THEME=""
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# disable case-sensitive completion
CASE_SENSITIVE="false"

# `_` and `-` are interchangeable
HYPHEN_INSENSITIVE="false"

# set the time format for the history file
HIST_STAMPS="yyyy-mm-dd"
# commands starting from whitespace won't be saved in history
HIST_IGNORE_SPACE="true"

plugins=(
  # cheatsheet for the 3rd party commands
  aliases
  # completions for the `homebrew`
  brew
  # completions for the Docker CLI
  docker
  docker-compose
  # fuzzy auto-completion and key bindings
  fzf
  # completions for the GitHub CLI
  gh
  # completions for the `git`
  gitfast
  # completions for the `k9s`
  k9s
  # completions for the `poetry`
  poetry
)

source $ZSH/oh-my-zsh.sh

# =================================================
# zplug
# =================================================

# path to the `zplug` installation
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

source "$HOME/.zplugrc"

# =================================================
# Shell
# =================================================

source "$HOME/.shell/.aliases"
source "$HOME/.shell/.completions"
source "$HOME/.shell/.exports"
source "$HOME/.shell/.functions"
source "$HOME/.shell/.fzf"
source "$HOME/.shell/.keybindings"
source "$HOME/.shell/.widgets"

if [[ -f "$HOME/.shell/.local" ]]; then
  source "$HOME/.shell/.local"
fi

# =================================================
# Misc
# =================================================

# display system information on shell startup
neofetch
