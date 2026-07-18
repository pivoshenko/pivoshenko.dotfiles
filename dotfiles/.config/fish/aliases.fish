# == Brew ==
alias b="brew"
alias bi="brew install"
alias bu="brew uninstall"
alias bl="brew list"
alias bc="brew cleanup --prune=all"
alias bd="brew doctor"

# == Core ==
alias cat="bat"
alias ls="eza --all --icons=always"

# == Docker ==
alias d="docker"
alias dco="docker compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias dpsl="docker ps -l -q"
alias dx="docker exec -it"

# == External tools ==
alias ld="lazydocker"
alias lg="lazygit"
alias zj="zellij"

# == Git ==
alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit -m"
alias gca="git commit -a --amend"
alias gd="git diff"
alias gph="git push"
alias gpl="git pull --rebase"
alias gr="git reset"
alias grb="git rebase"
alias grbi="git rebase -i"
alias gs="git switch"
alias gst="git status"

# == Kubernetes ==
alias k="kubectl"
alias ka="kubectl apply -f"
alias kc="kubectx"
alias kcn="kubectl config set-context --current --namespace"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias ke="kubectl exec -it"
alias kg="kubectl get"
alias kgd="kubectl get deployments"
alias kgp="kubectl get pod"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias kns="kubens"

# == UV ==
alias u="uv"
alias uva="uv add"
alias uvl="uv lock"
alias uvr="uv run"
alias uvs="uv sync -U --all-groups --all-extras"
alias uvv="uv venv"
