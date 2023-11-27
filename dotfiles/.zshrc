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
    colorize
    copypath
    docker
    docker-compose
    fast-syntax-highlighting
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

# configure starship
eval "$(starship init zsh)"

# configure dotenv
eval "$(direnv hook zsh)"

# configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# configure nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"
export NODE_NO_WARNINGS=1

# configure bun
[ -s "/Users/volodymyr.pivoshenko/.oh-my-zsh/completions/_bun" ] && source "/Users/volodymyr.pivoshenko/.oh-my-zsh/completions/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# configure spicetify
export PATH=$PATH:$HOME/.spicetify

# set default editor
export EDITOR=hx
export VISUAL="$EDITOR"

# configure exa
alias ls="exa --tree --level=1 --icons"

# configure bat
alias cat="bat -p"

# configure commitizen
alias czc="cz c"

# configure lazygit
alias lg="lazygit"
export XDG_CONFIG_HOME="$HOME/.config"

# configure lazydocker
alias ld="lazydocker"

# configure atuin
eval "$(atuin init zsh)"
alias history="atuin search -i"
alias h="atuin search -i"

# configure navi
eval "$(navi widget zsh)"

# configure zellij
eval "$(zellij setup --generate-auto-start zsh)"
alias zj="zellij"

# configure zoxide
eval "$(zoxide init zsh)"

# run neofetch
neofetch

# fig post block
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
