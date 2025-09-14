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
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end
if test -f $HOME/.config/fish/.env.fish
    source $HOME/.config/fish/.env.fish
end
