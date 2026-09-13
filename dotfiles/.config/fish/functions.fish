# == Logging Helpers ==
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

# == Delete Backup Files ==
function bakclean
  __log "Removing backup files"
  fd -H -e ".bak" -t f -x rm
  fd -H -e ".backup" -t f -x rm
  __log_ok "Backup files removed"
end

# == Reload Fish Configuration ==
function reload
  source ~/.config/fish/config.fish
end

# == Display System Information on Shell Startup ==
function fish_greeting
  fastfetch
end

# == Show the Running Command in the Terminal/Tab Title ==
function fish_title
  set -l command (status current-command)
  test "$command" = fish; and set command (prompt_pwd -d 1 -D 1)
  echo -- $command
end

# == Activate a Virtual Environment ==
function venv
  __log "Activating virtual environment"
  source .venv/bin/activate.fish
  __log_ok "Virtual environment activated"
end

# == Iterate over Sub-Directories and Pull Git Repositories ==
function gplr
  __log "Pulling all Git repositories under (pwd)"
  set -l steps 'echo "==> updating {}"' \
    'git -C {} fetch --all' \
    'git -C {} fetch --prune origin' \
    'git -C {} pull --rebase'
  find . -name ".git" -type d | sed 's/\/\.git//' | xargs -P10 -I{} sh -c (string join ' && ' $steps)
  __log_ok "Repositories updated"
end

# == Delete Local and Remote Branches Already Merged into the Main Branch ==
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
  set -l remote_merged (git branch -r --merged origin/$main \
    | grep -vE "origin/($main|master|develop)\$|->" \
    | sed 's|^\s*origin/||' | string trim)
  for branch in $remote_merged
    __log "deleting remote origin/$branch"
    git push origin --delete $branch
  end
  __log_ok "Merged branches cleaned"
end

# == Update System Packages ==
function update
  __log "Updating Homebrew packages"
  brew update --force
  brew upgrade --force --yes
  __log "Syncing Kasetto environment"
  kst sync -u
  __log_ok "System packages updated"
end

# == Fuzzy-Find a File and Open It in the Editor ==
function __fzf_edit
  set -l file (fzf --height 60% --preview 'bat --style=numbers --color=always {}')
  if test -n "$file"
    commandline --replace "hx "(string escape -- $file)
    commandline --function execute
  else
    commandline --function repaint
  end
end
