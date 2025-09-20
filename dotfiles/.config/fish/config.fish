# == External tools ==
starship init fish | source
zoxide init fish | source
fzf --fish | source

# == Load individual shell configurations ==
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/exports.fish
source $HOME/.config/fish/functions.fish
source $HOME/.config/fish/vimode.fish
source $HOME/.config/fish/fzf.fish

# == Load individual local shell configurations ==
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end
if test -f $HOME/.config/fish/.env.fish
    source $HOME/.config/fish/.env.fish
end
if test -f $HOME/.config/fish/.secrets.fish
    source $HOME/.config/fish/.secrets.fish
end
