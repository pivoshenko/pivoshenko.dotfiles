# enable fig
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# enable oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# set theme
ZSH_THEME=""
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# plugins
plugins=(
    aws
    brew
    celery
    copypath
    colorize
    docker
    docker-compose
    git
    gcloud
    gh
    helm
    history
    kubectl
    minikube
    npm
    python
    poetry
    pip
    redis-cli
    rust
    tmux
    thefuck
    vscode
    zsh-autosuggestions
    zsh-vi-mode
)

# load oh-my-zsh's library
source $ZSH/oh-my-zsh.sh

# enable zsh-syntax-highlighting
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable starship promt
eval "$(starship init zsh)"

# update PATH for the Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# enable shell command completion for gcloud
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# set default AWS profile
export AWS_PROFILE="default"

# enable pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# enable nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# enable autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# enable spicetify
export PATH=$PATH:$HOME/.spicetify

# set hs as the default editor
export EDITOR=hx
export VISUAL="$EDITOR"

# enable exa
alias ls="exa --tree --level=1 --icons"

# enable Docker Desktop
source "$HOME/.docker/init-zsh.sh" || true

# enable hishtory
export PATH="$PATH:$HOME/.hishtory"
source "$HOME/.hishtory/config.zsh"
