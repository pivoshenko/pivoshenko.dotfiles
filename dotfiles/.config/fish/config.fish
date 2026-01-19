# == External tools ==
fzf --fish | source
pyenv init - fish | source
starship init fish | source
zoxide init fish | source

# == Individual configurations ==
source $HOME/.config/fish/aliases.fish
source $HOME/.config/fish/exports.fish
source $HOME/.config/fish/fzf.fish
source $HOME/.config/fish/functions.fish
source $HOME/.config/fish/vimode.fish

# == Local configurations ==
if test -f $HOME/.config/fish/local.fish
    source $HOME/.config/fish/local.fish
end

# == Theme ==
fish_config theme choose "catppuccin_mocha"
