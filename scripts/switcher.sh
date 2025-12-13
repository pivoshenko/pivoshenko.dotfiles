#!/bin/bash

is_dark_mode() {
    defaults read -g AppleInterfaceStyle 2>/dev/null | grep -q "Dark"
    return $?
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PYTHON_SCRIPT="$SCRIPT_DIR/switcher.py"

# Run the Python theme switcher
if is_dark_mode; then
    echo "Dark mode detected - switching themes"
    python3 "$PYTHON_SCRIPT" dark
else
    echo "Light mode detected - switching themes"
    python3 "$PYTHON_SCRIPT" light
fi
