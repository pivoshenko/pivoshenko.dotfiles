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

# configure starship
eval "$(starship init zsh)"

# configure dotenv
eval "$(direnv hook zsh)"

# configure pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# configure pdm
pdm() {
    local command=$1
    if [[ $command == "shell" ]]; then
        eval $(pdm venv activate)
    else
        command pdm $@
    fi
}

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
eval "$(atuin init zsh --disable-up-arrow --disable-ctrl-r)"
alias history="atuin search -i"
alias h="atuin search -i"

# configure fzf
alias f='hx "$(fzf)" 2>/dev/null'
export FZF_DEFAULT_COMMAND=" \
fd --type f --type l \
--hidden \
--follow \
--exclude .git \
--exclude venv \
--exclude .pytest_cache \
--exclude .mypy_cache \
--exclude __pycache__ \
--exclude .hypothesis \
--exclude .ruff_cache \
--exclude .ipynb_checkpoints
"
export FZF_DEFAULT_OPTS=" \
--preview 'bat -n --color=always {}' \
--height 50% -1 \
--reverse \
--preview-window='right:wrap' \
--inline-info \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
"

# configure keybindings
function zvm_after_init() {
    # fzf
    zvm_bindkey viins '^R' fzf-history-widget
    bindkey -s '^f' '^uhx "$(fzf)" 2>/dev/null^M'
    source ~/.fzf.zsh
}

# configure zellij
eval "$(zellij setup --generate-auto-start zsh)"
alias zj="zellij"

# configure zoxide
eval "$(zoxide init zsh)"

# run neofetch
neofetch

# fig post block
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
