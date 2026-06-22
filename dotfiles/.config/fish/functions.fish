# == Logging helpers ==
function __log
  set_color --bold cyan
  printf '==> '
  set_color normal
  printf '%s\n' "$argv"
end

function __log_ok
  set_color --bold green
  printf '✓   '
  set_color normal
  printf '%s\n' "$argv"
end

# == Delete backup files ==
function bakclean
  __log "Removing backup files"
  fd -H -e ".dotdropbak" -t f -x rm
  fd -H -e ".bak" -t f -x rm
  fd -H -e ".backup" -t f -x rm
  __log_ok "Backup files removed"
end

# == Reload Fish configuration ==
function fish
  source ~/.config/fish/config.fish
end

# == Display system information on shell startup ==
function fish_greeting
  fastfetch
end

# == Activate a virtual environment ==
function venv
  __log "Activating virtual environment"
  source .venv/bin/activate.fish
  __log_ok "Virtual environment activated"
end

# == Iterate over sub-directories and pull Git repositories ==
function gplr
  __log "Pulling all Git repositories under (pwd)"
  find . -name ".git" -type d | sed 's/\/\.git//' | xargs -P10 -I{} sh -c 'echo "==> updating {}" && git -C {} fetch --all && git -C {} fetch --prune origin && git -C {} pull --rebase'
  __log_ok "Repositories updated"
end

# == Delete local and remote branches already merged into the main branch ==
function gbc
  set -l main (git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||')
  test -z "$main"; and set main main
  __log "Cleaning branches merged into $main"
  git checkout $main
  git fetch --prune origin
  __log "Deleting local merged branches"
  for branch in (git branch --merged $main | grep -vE "^[+*]|^\s*($main|master|develop)\$" | string trim)
    __log "deleting local $branch"
    git branch -d $branch
  end
  __log "Deleting remote merged branches on origin"
  for branch in (git branch -r --merged origin/$main | grep -vE "origin/($main|master|develop)\$|->" | sed 's|^\s*origin/||' | string trim)
    __log "deleting remote origin/$branch"
    git push origin --delete $branch
  end
  __log_ok "Merged branches cleaned"
end

# == Update system packages ==
function update
  __log "Updating Homebrew packages"
  brew update --force
  brew upgrade --force --yes
  __log "Syncing Kasetto environment"
  kst sync -u
  __log_ok "System packages updated"
end
