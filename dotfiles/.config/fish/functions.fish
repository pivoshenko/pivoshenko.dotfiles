# Delete backup files
function bakclean
    fd -H -e ".dotdropbak" -t f -x rm
    fd -H -e ".bak" -t f -x rm
end

# Iterate over sub-directories and pull `git` repositories
function rgp
    find . -name ".git" -type d | sed 's/\/\.git//' | xargs -P10 -I{} sh -c 'git -C {} fetch --all && git -C {} pull'
end

# Reload `fish` configuration
function fish
  source ~/.config/fish/config.fish
end
