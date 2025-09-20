# == Delete backup files ==
function bakclean
  fd -H -e ".dotdropbak" -t f -x rm
  fd -H -e ".bak" -t f -x rm
  fd -H -e ".backup" -t f -x rm
end

# == Iterate over sub-directories and pull Git repositories ==
function rgp
  command find . -name ".git" -type d | sed 's/\/\.git//' | xargs -P10 -I{} sh -c 'git -C {} fetch --all && git -C {} pull'
end

# == Reload Fish configuration ==
function fish
  source ~/.config/fish/config.fish
end

# == Display system information on shell startup ==
function fish_greeting
  fastfetch
end
