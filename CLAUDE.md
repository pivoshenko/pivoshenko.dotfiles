# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles focused on minimalism, consistency, and cross-tool theming, bundling:

- **Brew dependencies** — apps, fonts, LSPs, extensions — in `Brewfile`.
- **Apps and tools config** — in `dotfiles/.config/`.
- **Claude Code setup** — `settings.json`, statusline — in `dotfiles/.claude/`. The global `CLAUDE.md` is NOT a managed copy: its canonical home is `pivoshenko.ai/rules/CLAUDE.md`, and the `claude_md_symlink` action symlinks `~/.claude/CLAUDE.md` to it on deploy.
- **Git, SSH, GPG** — `.gitconfig`, `.ssh/`, `.gnupg/`.

Managed by **DotDrop**: config sources live in `dotfiles/` and get copied (not symlinked) to their destinations. A unified theme (`morok` / `popil` / `vatra`) is applied across all tools.

## Key Commands

```bash
just install              # everything: brew + dotfiles
just brew                 # Homebrew packages, casks, fonts, extensions only
just dotfiles             # deploy dotfiles to the system (all profiles) only
just set-flavor FLAVOR    # activate a theme flavor (morok | popil | vatra)
```

`install` is just `brew` + `dotfiles` — run either alone when you only need one half. No linter or test suite. Theme **sync** (vendoring all flavors from `pivoshenko.theme/themes/dist`) lives one level up: run `just sync-theme` from the `me/` root (script: `../scripts/sync_theme.py`). Theme **activation** is local: `just set-flavor <flavor>` flips every loader in this repository to the chosen flavor (script: `scripts/set_flavor.py`); run `just dotfiles` afterward to deploy onto the system.

## Architecture

### DotDrop (`dotdrop.config.yaml`)

Maps source paths under `dotfiles/` to destination paths on the system. Two profiles:
- **default** — cross-platform configs (`~/.config/*`, `~/.gitconfig`, `~/.ssh`, etc.)
- **me** — machine-specific personal targets: the zen browser theme (`userChrome.css`/`userContent.css` → the active profile's `chrome/`, plus arkenfox `user-overrides.js` → the profile root). The zen profile id in `dotdrop.config.yaml` is machine-specific.

Files are copied, not symlinked (`link_dotfile_default: nolink`). No Jinja2 templating is used.

### Directory Layout

- `dotfiles/.config/` — XDG config home: fish, helix, ghostty, bat, delta, k9s, lazygit, zed, zellij, karabiner, rectangle, bottom, fastfetch, spicetify, stylus, zen (dirs), plus `starship.toml` (single file)
- `dotfiles/.claude/` — Claude Code config (`settings.json`, `statusline-command.sh`; global `CLAUDE.md` is symlinked from `pivoshenko.ai/rules/`)
- `dotfiles/.gitconfig` — Git config (editor: helix, pager: delta, GPG signing)
- `dotfiles/.ssh/`, `dotfiles/.gnupg/` — SSH and GPG configs
- `Brewfile` — all packages, casks, fonts, and LSPs

### Shell: Fish

Primary config in `dotfiles/.config/fish/`:
- `config.fish` — initializes fzf, pyenv, starship, zoxide
- `aliases.fish` — aliases for brew, git, docker, helm, kubernetes, uv
- `exports.fish` — environment variables (EDITOR=hx, XDG paths, GPG_TTY)
- `functions.fish` — custom functions (bakclean, venv, rgp)
- `fish_plugins` — Fisher plugins
- Local overrides: `~/.config/fish/local.fish` and `~/.config/fish/.secrets.fish` (gitignored)

### Theme (morok / popil / vatra)

Custom theme applied consistently to: fish, starship, helix, zed, ghostty, k9s, bottom, lazygit, zellij, bat, fastfetch, spicetify, zen, stylus (browser CSS), obsidian. Source: `github.com/pivoshenko/pivoshenko.theme`. All three flavors — **morok**, **popil**, **vatra** — are vendored side-by-side under each tool's themes/ directory; one is active at a time.

**Sync (vendor every flavor):** `just sync-theme` from the `me/` root (script: `../scripts/sync_theme.py`) pulls all flavors from `../pivoshenko.theme/themes/dist`. Most tools load a theme file natively (ghostty, helix, zed, bat, k9s, lazygit theme, zellij, zen, spicetify, fish, fzf) — sync copies one file per flavor into `.config/<tool>/themes/<flavor>.<ext>`. The one config that can't include externally — `starship.toml` — has all three `[palettes.<flavor>]` blocks spliced in by sync, and the top-level `palette = "<flavor>"` picks the active one. Delta themes live in `.config/delta/themes/<flavor>.gitconfig`, all 3 included from `.gitconfig`; `[delta] features = "<flavor>"` picks.

**Activate (flip the active flavor):** `just set-flavor <flavor>` (script: `scripts/set_flavor.py`) rewrites every loader in this repository to point at the chosen flavor — `palette = …`, `theme = …`, `features = …`, `skin: …`, `--theme=…`, ghostty `theme = <f>.conf`, `source themes/fzf-<f>.fish`, `$FZF_<F>`, zed `theme.{light,dark}`, fish `fish_config theme choose`. Configs with no include mechanism are rewritten wholesale from their `themes/<f>.*` file: `.config/bottom/bottom.toml` (← `bottom/themes/<f>.toml`), `.config/fastfetch/config.jsonc` (← `fastfetch/themes/<f>.jsonc`), and the `gui.theme:` block in `lazygit/config.yml` (spliced from `lazygit/themes/<f>.yml`). Zen `src:` paths in `dotdrop.config.yaml` are flipped too. After running, `just dotfiles` deploys onto the system. For tools whose theme is picked by a UI/CLI (Stylus, Obsidian, Spicetify, VSCode), switch inside the tool — sync still drops every flavor file in place.

## Conventions

- **Formatting:** UTF-8, LF line endings, 2-space indent (4 for Python), 120-char max line length, trailing whitespace trimmed (see `.editorconfig`)
- **Font:** JetBrains Mono Nerd Font everywhere
- **Adding a new tool config:** create directory under `dotfiles/.config/<tool>/`, add a dotfile entry in `dotdrop.config.yaml`, and include it in the appropriate profile
- **Wording:** never use "repo" — always write "repository" in prose, comments, and commit messages
