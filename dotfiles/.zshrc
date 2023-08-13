# enable fig
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# enable oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"

# set theme
ZSH_THEME=""
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# list of plugins
plugins=(
    aws
    brew
    celery
    copypath
    colorize
    docker
    docker-compose
    git
    git-auto-fetch
    gcloud
    gh
    helm
    history
    kubectl
    minikube
    npm
    nvm
    node
    python
    poetry
    pip
    redis-cli
    rust
    tmux
    thefuck
    vault
    vscode
    virtualenv
    wakatime
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-vi-mode
)

# load oh-my-zsh's library
source $ZSH/oh-my-zsh.sh

# run starship promt
eval "$(starship init zsh)"

# configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# configure nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# configure spicetify
export PATH=$PATH:$HOME/.spicetify

# configure default editor
export EDITOR=hx
export VISUAL="$EDITOR"

# configure exa
alias ls="exa --tree --level=1 --icons"

# configure bat
alias cat="bat -p"

# enaconfigureble ripgrep
# alias grep="rg"

# configure commitizen
alias czc="cz c"

# configure neovim
alias vim="nvim"

# configure lazygit
alias lg="lazygit"
export XDG_CONFIG_HOME="$HOME/.config"

# configure lazydocker
alias ld="lazydocker"

# enable history
eval "$(atuin init zsh)"
alias history="atuin search -i"
alias h="atuin search -i"

# update outdated packages after running brew commands
function brew() {
    command brew "$@"
    if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
        sketchybar --trigger brew_update
    fi
}

# run neofetch
neofetch

# fig post block
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
