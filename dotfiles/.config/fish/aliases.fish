# == Core commands ==
alias cat="bat"
alias find="fd"
alias grep="rg"
alias ls="eza --all --icons=always"

# == Docker ==
alias dco="docker compose"
alias dl="docker ps -l -q"
alias dpa="docker ps -a"
alias dps="docker ps"
alias dx="docker exec -it"

# == External tools ==
alias ld="lazydocker"
alias lg="lazygit"
alias zj="zellij"

# == Git ==
alias ga="git add"
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -m"
alias gca="git commit -a --amend"
alias gd="git diff"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gr="git reset"
alias gri="git rebase -i"
alias gs="git switch"
alias gst="git status"
alias gu="git reset HEAD~1 --mixed"

# == Kubernetes ==
alias k="kubectl"
alias ka="kubectl apply -f"
alias kb="kubectl describe"
alias kc="kubectx"
alias kcns="kubectl config set-context --current --namespace"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias ke="kubectl exec -it"
alias kg="kubectl get"
alias kgd="kubectl get deployments"
alias kgpo="kubectl get pod"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias kns="kubens"
