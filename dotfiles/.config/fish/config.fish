# =================================================
# External tools
# =================================================

# initialize `starship` prompt
starship init fish | source

# initialize `zoxide`
zoxide init fish | source

# initialize `fzf`
fzf --fish | source

# initialize `pyenv`
pyenv init - fish | source

# display system information on shell startup
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

# load shell configuration specific to the current host
if test -f $HOME/.shell/.local
    source $HOME/.shell/.local
end

# load common environment variables / secrets
if test -f $HOME/.shell/.env
    source $HOME/.shell/.env
end
