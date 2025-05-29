# =================================================
# External tools
# =================================================

# Initialize `starship` prompt
starship init fish | source

# Initialize `zoxide`
zoxide init fish | source

# Initialize `fzf`
fzf --fish | source

# Initialize `pyenv`
pyenv init - fish | source

# Display system information on shell startup
function fish_greeting
    fastfetch
end

# =================================================
# Individual shell configurations
# =================================================

source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/exports.fish
source $HOME/.config/fish/functions.fish
source $HOME/.config/fish/vimode.fish
source $HOME/.config/fish/fzf.fish

# Load shell configuration specific to the current host
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

# Load common environment variables / secrets
if test -f $HOME/.config/fish/.env.fish
    source $HOME/.config/fish/.env.fish
end
