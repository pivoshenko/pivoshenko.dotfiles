# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS managed by **DotDrop**. All config sources live in `dotfiles/` and get copied (not symlinked) to their destinations. A unified **Morok** theme is applied across all tools.

## Key Commands

```bash
# Install Homebrew packages, casks, fonts, and extensions
brew bundle

# Deploy dotfiles (two profiles)
dotdrop install -c dotdrop.config.yaml -p default --force
dotdrop install -c dotdrop.config.yaml -p macos --force
```

There is no build system, linter, or test suite for this repository.

## Architecture

### DotDrop (`dotdrop.config.yaml`)

Maps source paths under `dotfiles/` to destination paths on the system. Two profiles:
- **default** — cross-platform configs (`~/.config/*`, `~/.gitconfig`, `~/.ssh`, etc.)
- **macos** — macOS-specific paths (VSCode at `~/Library/Application Support/Code/User`)

Files are copied, not symlinked (`link_dotfile_default: nolink`). No Jinja2 templating is used.

### Directory Layout

- `dotfiles/.config/` — XDG config home: fish, helix, ghostty, starship, bat, delta, k9s, lazygit, zed, zellij, karabiner, rectangle, and more
- `dotfiles/.gitconfig` — Git config (editor: helix, pager: delta, GPG signing)
- `dotfiles/.ssh/`, `dotfiles/.gnupg/` — SSH and GPG configs
- `dotfiles/vscode/` — VSCode/Cursor settings, keybindings, and Morok theme
- `macos/agents/` — macOS LaunchAgents (dark mode notify)
- `Brewfile` — all packages, casks, fonts, LSPs, and VSCode extensions

### Shell: Fish

Primary config in `dotfiles/.config/fish/`:
- `config.fish` — initializes fzf, pyenv, starship, zoxide
- `aliases.fish` — aliases for brew, git, docker, helm, kubernetes, uv
- `exports.fish` — environment variables (EDITOR=hx, XDG paths, GPG_TTY)
- `functions.fish` — custom functions (bakclean, venv, rgp)
- `fish_plugins` — Fisher plugins
- Local overrides: `~/.config/fish/local.fish` and `~/.config/fish/.secrets.fish` (gitignored)

### Morok Theme

Custom theme applied consistently to: fish, starship, helix, VSCode, zed, ghostty, k9s, bottom, lazygit, zellij, bat, spicetify, zen, stylus (browser CSS). Source: `github.com/pivoshenko/pivoshenko.theme`.

## Conventions

- **Formatting:** UTF-8, LF line endings, 2-space indent (4 for Python), 120-char max line length, trailing whitespace trimmed (see `.editorconfig`)
- **Font:** JetBrains Mono Nerd Font everywhere
- **Adding a new tool config:** create directory under `dotfiles/.config/<tool>/`, add a dotfile entry in `dotdrop.config.yaml`, and include it in the appropriate profile
