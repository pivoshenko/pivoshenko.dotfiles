# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_THEME=""
ZSH_COLORIZE_CHROMA_FORMATTER=terminal256

# Plugins.
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
    heroku
    jfrog
    kubectl
    mvn
    minikube
    npm
    python
    poetry
    pip
    redis-cli
    rust
    sbt
    scala
    spring
    tmux
    thefuck
    vscode
    zsh-autosuggestions
    zsh-vi-mode
    zsh-wakatime
)

# Load the oh-my-zsh's library.
source $ZSH/oh-my-zsh.sh

# Enable zsh-syntax-highlighting.
source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Update PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# Enable shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Set default AWS profile.
export AWS_PROFILE="default"

# Activate pyenv.
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Activate nvm.
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Activate autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Enable spicetify.
export PATH=$PATH:$HOME/.spicetify

# Enable starship promt.
eval "$(starship init zsh)"

# Set default editor.
export EDITOR=hx
export VISUAL="$EDITOR"

# Enable tea.
add-zsh-hook -Uz chpwd(){ source <(tea -Eds) }

# Enable exa.
alias ls="exa --tree --level=1 --icons"

# Enable Docker Desktop.
source "$HOME/.docker/init-zsh.sh" || true 

# Enable hishtory.
export PATH="$PATH:$HOME/.hishtory"
source "$HOME/.hishtory/config.zsh"

# Activate WakaTime plugin.
export ZSH_WAKATIME_PROJECT_DETECTION=true
