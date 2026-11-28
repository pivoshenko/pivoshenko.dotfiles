# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`pivoshenko.dotfiles` is a personal macOS dotfiles repository. There is no application to build, and the only tests are a small pytest suite over the IPython config - the "product" is the `dotfiles/` staging tree, which [dotdrop](https://github.com/deadc0de6/dotdrop) deploys into `$HOME`, orchestrated by [just](https://github.com/casey/just). There are no standalone scripts; the executable code is itself deployed config - `dotfiles/.claude/statusline-command.sh`, the fish files under `dotfiles/.config/fish/`, and `dotfiles/.ipython/profile_default/startup/start.py`.

## Commands

`just --list` is the index. The ones that matter:

- `just install` - full bootstrap (brew bundle, both dotdrop profiles, Fisher plugins, `bat` cache, vault symlink, macOS app defaults)
- `just install-dotfiles` - deploy the `default` and `me` profiles with `--force`; this is the verification step after any change under `dotfiles/`
- `just install-macos-defaults` - `defaults write` for apps configured only through their preferences plist (f.lux, Tailscale). Keys are written one by one rather than importing a whole plist, which would carry window frames, update timestamps, and device IDs
- `just install-brew-packages` - `brew bundle` plus `brew bundle cleanup --force`, so removing a line from `Brewfile` uninstalls the package
- `just format` / `just lint` - Ruff and ty over the Python files, `fish_indent` over the tracked fish files.

There are no GitHub Actions workflows in this repository. `just test` runs the pytest suite in `tests/` (it covers the IPython profile files via `runpy`, since `dotfiles/` is not an importable package).

## Architecture

### Staging Tree and Deployment

`dotfiles/` mirrors the layout of `$HOME` (`dotfiles/.config/fish/` -> `~/.config/fish/`). `dotdrop.config.yaml` maps each entry explicitly and assigns it to a profile:

- `default` - everything machine-agnostic (shell, editors, CLI tools, git, ssh, gpg, Claude settings)
- `me` - entries with hardcoded personal paths: the iCloud Obsidian vault and the Zen browser profile directory (`6im8xt7o.Default (release)`)

`link_dotfile_default: nolink`, so dotdrop **copies** rather than symlinks. Editing a file under `~/.config/` does not flow back into the repository. Always edit under `dotfiles/` and redeploy.

Adding a newly managed config is three coordinated edits:

1. Add the file or directory under `dotfiles/`
2. Add a `d_*` (directory) or `f_*` (file) entry to the `dotfiles:` block in `dotdrop.config.yaml`
3. Add that key to a profile under `profiles:`

### Theme

The repo vendors one flavor of [pivoshenko.theme](https://github.com/pivoshenko/pivoshenko.theme), `morok`, and each tool loads it the way it natively supports:

- **Named theme file** - the live config selects `morok` and the file sits beside it: helix, k9s (`skins/`), bat, ghostty, zed, fish (`fish_config theme choose`, plus `ls-colors-morok.fish` and `fzf-morok.fish`), delta (`[delta] features` and an `[include]` in `.gitconfig`), herdr-app (`"theme"` in `settings.json`), Obsidian, Spicetify (`Themes/morok/`)
- **Inlined** - the colors live inside the live config itself: starship `[palettes.morok]`, bottom, fastfetch, herdr `[theme]`, lazygit `gui.theme`
- **Plain files** - Zen `userChrome.css`/`userContent.css`, the Chrome unpacked-extension `manifest.json`, the Stylus `morok.json` export

Consequences when touching theming:

- A palette change upstream is re-vendored by hand: copy the new `morok` files over, and edit the inlined blocks in place
- lazygit reads `authorColors` at `gui.theme.authorColors`; `gui.authorColors` is the wrong path
- Apps that own their own settings store stay manual: Obsidian, Telegram, Discord/Vesktop, Stylus, Chrome, Rectangle, Spotify. `README.md` documents each

### Plugin Manifests

Plugins are tracked as plain line-per-entry manifests rather than recipe arguments, so adding one is a one-line diff:

- `dotfiles/.config/fish/fish_plugins` - read by Fisher

### Agent Configuration

`dotfiles/.claude/` carries only `settings.json` and `statusline-command.sh`. The global `CLAUDE.md`/`AGENTS.md` instruction set does **not** live here - it is distributed across machines by [Kasetto](https://kasetto.dev/) from [`pivoshenko/pivoshenko.ai`](https://github.com/pivoshenko/pivoshenko.ai), as individual instruction files under `instructions/`. Do not reintroduce global agent rules into this repository.

## Untracked Local Files

Three files are deliberately not in the repo and must exist on each machine:

- `~/.gitconfig.local` - the `[user]` block. `.gitconfig` sets `useConfigOnly = true` and `commit.gpgsign = true`, so git refuses to commit without it and needs a `signingkey`
- `~/.config/fish/local.fish` - machine-specific shell config
- `~/.config/fish/.secrets.fish` - tokens and keys

Both fish files are sourced conditionally at the end of `config.fish`.

## Conventions

- Config files group related settings under `# == Group ==` headers (Brewfile, `dotdrop.config.yaml`, the fish files, `herdr/config.toml`, the statusline script). Match that style rather than inventing separators
- `.editorconfig`: LF, UTF-8, 2-space indent (4 for Python and Rust), 120-column max, trailing whitespace trimmed
- Conventional Commits with an area scope, imperative lowercase subject, no trailing period: `feat(fish): add the cargo bin directory to PATH`
- Branches are `<type>/<kebab-description>` using the same type prefixes
- Keep `README.md` and `CONTRIBUTING.md`'s recipe table in sync when adding or renaming a `just` recipe
