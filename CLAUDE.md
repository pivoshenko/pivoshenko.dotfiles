# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS managed by **DotDrop**. All config sources live in `dotfiles/` and get copied (not symlinked) to their destinations. A unified **Popil** theme is applied across all tools.

## Key Commands

```bash
just install      # everything: brew + dotfiles
just brew         # Homebrew packages, casks, fonts, extensions only
just dotfiles     # deploy dotfiles to the system (all profiles) only
```

`install` is just `brew` + `dotfiles` — run either alone when you only need one half. No linter or test suite. Theme sync lives one level up: run `just sync-theme [FLAVOR]` from the `me/` root (script: `../scripts/sync-theme.py`).

## Architecture

### DotDrop (`dotdrop.config.yaml`)

Maps source paths under `dotfiles/` to destination paths on the system. Three profiles:
- **default** — cross-platform configs (`~/.config/*`, `~/.gitconfig`, `~/.ssh`, etc.)
- **macos** — macOS-specific paths (VSCode at `~/Library/Application Support/Code/User`)
- **me** — machine-specific personal targets: the zen browser theme (`userChrome.css`/`userContent.css` → the active profile's `chrome/`, plus arkenfox `user-overrides.js` → the profile root). The zen profile id in `dotdrop.config.yaml` is machine-specific.

Files are copied, not symlinked (`link_dotfile_default: nolink`). No Jinja2 templating is used.

### Directory Layout

- `dotfiles/.config/` — XDG config home: fish, helix, ghostty, bat, delta, k9s, lazygit, zed, zellij, karabiner, rectangle, bottom, fastfetch, spicetify, stylus, zen (dirs), plus `starship.toml` (single file)
- `dotfiles/.claude/` — Claude Code config (`CLAUDE.md` global memory, `settings.json`, `statusline-command.sh`)
- `dotfiles/.gitconfig` — Git config (editor: helix, pager: delta, GPG signing)
- `dotfiles/.ssh/`, `dotfiles/.gnupg/` — SSH and GPG configs
- `dotfiles/vscode/` — VSCode/Cursor settings, keybindings, and Popil theme
- `Brewfile` — all packages, casks, fonts, LSPs, and VSCode extensions

### Shell: Fish

Primary config in `dotfiles/.config/fish/`:
- `config.fish` — initializes fzf, pyenv, starship, zoxide
- `aliases.fish` — aliases for brew, git, docker, helm, kubernetes, uv
- `exports.fish` — environment variables (EDITOR=hx, XDG paths, GPG_TTY)
- `functions.fish` — custom functions (bakclean, venv, rgp)
- `fish_plugins` — Fisher plugins
- Local overrides: `~/.config/fish/local.fish` and `~/.config/fish/.secrets.fish` (gitignored)

### Popil Theme

Custom theme applied consistently to: fish, starship, helix, VSCode, zed, ghostty, k9s, bottom, lazygit, zellij, bat, spicetify, zen, stylus (browser CSS). Source: `github.com/pivoshenko/pivoshenko.theme`. Only the **popil** flavor is vendored here; the morok bundle has been removed.

**Syncing theme changes:** the theme is vendored from the sibling `../pivoshenko.theme` repo. After re-rendering there (`just render`), run `just sync-theme` from the `me/` root (script: `../scripts/sync-theme.py`) to pull the artifacts into this repo. The script does verbatim copies for tools that load a theme file natively (ghostty, helix, zed, bat, k9s, lazygit theme, zellij, vscode, zen, spicetify, fish fzf), and patches in place the two configs that embed the palette inline with no include mechanism: `starship.toml` (`[palettes.<flavor>]` block — starship has no include) and `lazygit/config.yml` (`gui.theme` — hand-maintained with comments). fzf colors live in `.config/fish/themes/fzf-<flavor>.fish`, sourced by `fzf.fish`. Switch flavor by passing `just sync-theme <flavor>` and updating the hardcoded flavor name in each tool's loader (`ghostty/config`, `helix/config.toml`, `zed/settings.json`, `fzf.fish`, etc.).

## Conventions

- **Formatting:** UTF-8, LF line endings, 2-space indent (4 for Python), 120-char max line length, trailing whitespace trimmed (see `.editorconfig`)
- **Font:** JetBrains Mono Nerd Font everywhere
- **Adding a new tool config:** create directory under `dotfiles/.config/<tool>/`, add a dotfile entry in `dotdrop.config.yaml`, and include it in the appropriate profile
