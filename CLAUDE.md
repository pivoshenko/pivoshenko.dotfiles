# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

`pivoshenko.dotfiles` is a personal macOS dotfiles repository. There is no application to build and no test suite - the "product" is the `dotfiles/` staging tree, which [dotdrop](https://github.com/deadc0de6/dotdrop) deploys into `$HOME`, orchestrated by [just](https://github.com/casey/just). The only standalone script is `scripts/set_flavor.py` (stdlib Python 3, no dependencies); the rest of the executable code is itself deployed config - `dotfiles/.claude/statusline-command.sh`, the fish files under `dotfiles/.config/fish/`, and `dotfiles/.ipython/profile_default/startup/start.py`.

## Commands

`just --list` is the index. The ones that matter:

- `just install` - full bootstrap (brew bundle, both dotdrop profiles, Fisher plugins, `bat` cache, vault symlink, herdr integration and plugins)
- `just install-dotfiles` - deploy the `default` and `me` profiles with `--force`; this is the verification step after any change under `dotfiles/`
- `just set-flavor <morok|popil|vatra>` - rewrite the repo's configs to a theme flavor, then `just install-dotfiles` to deploy
- `just set-spicetify-flavor <morok|popil|vatra>` - Spotify only, applied directly to the live spicetify install
- `just install-brew-packages` - `brew bundle` plus `brew bundle cleanup --force`, so removing a line from `Brewfile` uninstalls the package

There are no linters, formatters, or GitHub Actions workflows wired up in this repository. `CONTRIBUTING.md` mentions tests; none exist here.

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

### Theme Flavors

The repo vendors three flavors of [pivoshenko.theme](https://github.com/pivoshenko/pivoshenko.theme) - `morok`, `popil`, `vatra` - and most themed tools keep all three on disk under a `themes/` (or `skins/`, `Themes/`) subdirectory. Three do not: starship inlines all three `[palettes.<flavor>]` tables in `starship.toml`, Zen keeps a directory per flavor at `dotfiles/.config/zen/<flavor>/`, and Stylus keeps flat `dotfiles/.config/stylus/<flavor>.json` files. `scripts/set_flavor.py` is the single authority that flips the live config over, and it uses four distinct mechanisms depending on what the tool supports:

- **Selector rewrite** - regex-swap a name in the live config: starship `palette`, helix `theme`, k9s `skin`, bat `--theme`, ghostty `theme = <f>.conf`, zed `"theme"` block, fish `fish_config theme choose`, `fzf.fish` source line and `FZF_THEME`, and `.gitconfig`'s `[delta] features` (all three delta gitconfigs are `[include]`d, so only the selector changes)
- **Whole-file copy** - `themes/<flavor>.<ext>` overwrites the live config: bottom, fastfetch
- **Block splice** - the flavor file's body is spliced into a section of the live config: herdr (between `[theme]` and the `# == Keys ==` marker) and lazygit (the `gui.theme:` block, re-indented)
- **dotdrop source rewrite** - Zen has no runtime theme selector, so the script rewrites `src: .config/zen/<flavor>/userC*` inside `dotdrop.config.yaml`

Consequences when touching theming:

- Those anchors are load-bearing, and they fail differently. Removing the `# == Keys ==` comment from `herdr/config.toml` aborts `set_flavor.py` loudly, with a `ValueError` from `text.index`. Reindenting or moving lazygit's `gui.theme` block fails silently instead: the regex stops matching, so `edit` sees no change and prints `ok` while patching nothing. Reflowing zed's `"theme": { ... }` onto one line is safe - `patch_zed`'s regexes match either form
- A new themed tool needs a vendored file per flavor **and** a corresponding step in `set_flavor.py`
- `set_flavor.py` only edits the repository; nothing reaches the system until `just install-dotfiles`
- Apps that own their own settings store stay manual: Obsidian, Telegram, Discord/Vesktop, Stylus, Rectangle. `README.md` documents each

### Plugin Manifests

Plugins are tracked as plain line-per-entry manifests rather than recipe arguments, so adding one is a one-line diff:

- `dotfiles/.config/fish/fish_plugins` - read by Fisher
- `herdr.plugins` - read by `just install-herdr-plugins` (blank lines and `#` comments skipped)

### Agent Configuration

`dotfiles/.claude/` carries only `settings.json` and `statusline-command.sh`. The global `CLAUDE.md`/`AGENTS.md` instruction set does **not** live here - it is distributed across machines by [Kasetto](https://kasetto.dev/) from [`pivoshenko/pivoshenko.ai`](https://github.com/pivoshenko/pivoshenko.ai), as individual instruction files under `instructions/`. Do not reintroduce global agent rules into this repository.

`AGENTS.md` at the repo root is a symlink to `CLAUDE.md`. Edit `CLAUDE.md`; keep the symlink.

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
