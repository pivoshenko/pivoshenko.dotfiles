#!/bin/bash

is_dark_mode() {
    defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"
    return $?
}

is_dbeaver_running() {
    pgrep -f "DBeaver.app" > /dev/null
}

is_spotify_running() {
    pgrep -f "Spotify.app" > /dev/null
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/switcher.py"

LIGHT_THEME="catppuccin_latte"
DARK_THEME="catppuccin_mocha"

LIGHT_SCHEME="latte"
DARK_SCHEME="mocha"

if is_dark_mode; then
  echo "Dark mode detected - switching themes"
  python3 "$PYTHON_SCRIPT" dark
  THEME="$DARK_THEME"
  SCHEME="$DARK_SCHEME"
else
  echo "Light mode detected - switching themes"
  python3 "$PYTHON_SCRIPT" light
  THEME="$LIGHT_THEME"
  SCHEME="$LIGHT_SCHEME"
fi

# == Bat ==
echo "Rebuilding bat cache"
/opt/homebrew/bin/bat cache --build

# == DBeaver ==
if is_dbeaver_running; then
  echo "Restarting DBeaver to apply theme changes"
  pkill -f "DBeaver.app"
  sleep 2
  open "/Applications/DBeaver.app"
fi

# == Fish ==
echo "Switching Fish theme"
/opt/homebrew/bin/fish -c "echo y | fish_config theme save '$THEME'"
/opt/homebrew/bin/fish -c "fish_config choose '$THEME'"

# == Spotify ==
echo "Switching Spotify theme"
/opt/homebrew/bin/spicetify config current_theme catppuccin
/opt/homebrew/bin/spicetify config color_scheme $SCHEME
/opt/homebrew/bin/spicetify config inject_css 1 inject_theme_js 1 replace_colors 1 overwrite_assets 1
/opt/homebrew/bin/spicetify apply
if is_spotify_running; then
  echo "Restarting Spotify to apply theme changes"
  pkill -f "Spotify.app"
  sleep 2
  open "/Applications/Spotify.app"
fi
