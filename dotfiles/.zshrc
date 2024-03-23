# enable oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# set theme
ZSH_THEME=""
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# list of plugins
plugins=(
    aws
    brew
    bookmarks
    celery
    colorize
    copypath
    docker
    docker-compose
    fast-syntax-highlighting
    fzf
    gcloud
    gh
    git
    git-auto-fetch
    helm
    history
    kubectl
    minikube
    node
    npm
    nvm
    pip
    poetry
    python
    redis-cli
    rust
    thefuck
    vault
    virtualenv
    vscode
    wakatime
    zsh-autosuggestions
    zsh-vi-mode
)

# configure oh-my-zsh's library
source $ZSH/oh-my-zsh.sh


# run neofetch
neofetch
