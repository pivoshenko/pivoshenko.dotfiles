# Delete backup files
function bakclean
    fd -H -e ".dotdropbak" -t f -x rm
    fd -H -e ".bak" -t f -x rm
end

# Iterate over sub-directories and pull `git` repositories
function rgp
    find . -name ".git" -type d | sed 's/\/\.git//' | xargs -P10 -I{} sh -c 'git -C {} fetch --all && git -C {} pull'
end

# Load `.env` file from a filename passed as an argument
function loadenv
    if test (count $argv) -eq 0
        echo "Usage: loadenv <file>"
        return 1
    end
    for line in (cat $argv[1])
        # Ignore comments and empty lines
        if test (string match -qr '^\s*#' -- $line); or test -z "$line"
            continue
        end
        set --local key (string split -m 1 '=' $line)[1]
        set --local val (string split -m 1 '=' $line)[2]
        if test -n "$key" -a -n "$val"
            set -Ux $key $val
        end
    end
    echo "Loaded"
end

# Reload `fish` configuration
function fish
  source ~/.config/fish/config.fish
end
