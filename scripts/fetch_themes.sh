# This script updates theme files for the tooling

echo "Fetching themes. Hang tight :3"

# =============================================================================================
# iTerm2
# =============================================================================================

echo "Updating iTerm2"

dirpath="dotfiles/.iterm/colors"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.itermcolors" \
  https://github.com/catppuccin/iterm/raw/main/colors/catppuccin-mocha.itermcolors

# =============================================================================================
# bat
# =============================================================================================

echo "Updating bat"

dirpath="dotfiles/.config/bat/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.tmTheme" \
  https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

# =============================================================================================
# bottom
# =============================================================================================

echo "Updating bottom"

dirpath="dotfiles/.config/bottom/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.toml" \
  https://github.com/catppuccin/bottom/raw/main/themes/mocha.toml

# =============================================================================================
# FSH
# =============================================================================================

echo "Updating fsh"

dirpath="dotfiles/.config/fsh"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.ini" \
  https://github.com/catppuccin/zsh-fsh/raw/main/themes/catppuccin-mocha.ini

# =============================================================================================
# K9s
# =============================================================================================

echo "Updating k9s"

dirpath="dotfiles/.config/k9s/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.yaml" \
  https://github.com/catppuccin/k9s/raw/main/dist/catppuccin-mocha.yaml

# =============================================================================================
# lazygit
# =============================================================================================

echo "Updating lazygit"

dirpath="dotfiles/.config/lazygit/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.yaml" \
  https://github.com/catppuccin/lazygit/raw/main/themes/mocha/green.yml

# =============================================================================================
# qBittorrent
# =============================================================================================

echo "Updating qbittorrent"

dirpath="dotfiles/.config/qbittorrent/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.qbtheme" \
  https://github.com/catppuccin/qbittorrent/raw/main/mocha.qbtheme

# =============================================================================================
# lazygit
# =============================================================================================

echo "Updating spotify-tui"

dirpath="dotfiles/.config/spotify-tui/themes"
mkdir -p $dirpath

wget -O "$dirpath/catppuccin_mocha.yaml" \
  https://github.com/catppuccin/spotify-tui/raw/main/mocha.yml

echo "Done!"
