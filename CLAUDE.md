# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS dotfiles. Not an application: there is no build, no test suite, and no linter. The repository is a source of truth that gets deployed onto the machine, plus two Python scripts that keep theming consistent.

Three moving parts:

- `Brewfile` - every cask, formula, font, and VSCode extension (`brew bundle`)
- `dotfiles/` - the config tree that gets deployed (`dotdrop`)
- `scripts/set_flavor.py` - flips the active theme flavor across every tool's loader

## Commands

```shell
just                      # list every recipe
just install              # brew + dotfiles + vault-link + herdr-integration + herdr-plugins
just brew                 # brew bundle --force --cleanup --upgrade
just dotfiles             # dotdrop install for both profiles (default, me)
just vault-link           # symlink the iCloud Obsidian vault to ~/Vault
just herdr-integration    # reinstall the herdr agent-state hook for Claude Code
just herdr-plugins        # reinstall the herdr plugins (navigator)
just set-flavor FLAVOR    # activate morok | popil | vatra across all loaders
just spicetify FLAVOR     # spicetify config + apply (separate, not covered by set-flavor)
```

`just dotfiles` runs `dotdrop install -c dotdrop.config.yaml -p <profile> --force` for both profiles. `--force` overwrites whatever is on the system, so edit under `dotfiles/`, never in `~`.

Theme **sync** lives outside this repository: `python3 ../scripts/sync_theme.py` (the sibling `scripts/` directory at the `sources/` root; the script resolves its own paths, so cwd does not matter). It vendors all three flavors from `../pivoshenko.theme/themes/dist` into `dotfiles/`. There is no `justfile` at that level despite what the script's docstring implies.

## Architecture

### Deployment: dotdrop

`dotdrop.config.yaml` maps `src` paths (relative to `dotpath: dotfiles`) to absolute `dst` paths. Files are **copied, not symlinked** (`link_dotfile_default: nolink`), and no Jinja2 templating is used, so a deployed file is byte-identical to its source.

Two profiles:

- `default` - portable configs: `~/.config/*`, `~/.gitconfig`, `~/.ssh`, `~/.gnupg`, `~/.ipython`, `~/.claude/{settings.json,statusline-command.sh}`
- `me` - machine-specific destinations: the Obsidian vault's `.obsidian/{themes,snippets}` under an iCloud path, and Zen's `userChrome.css` / `userContent.css` / `user-overrides.js` under a hard-coded profile id (`6im8xt7o.Default (release)`). Both paths must be edited by hand on a new machine.

Most entries map a whole directory (`d_*`). A few map a single file (`f_*`) because the destination directory holds runtime state that must not be clobbered - notably `f_herdr_config` (`~/.config/herdr` also holds sockets, logs, and session state) and `f_starship`.

Adding a tool: create `dotfiles/.config/<tool>/`, add a `d_<tool>` (or `f_<tool>`) entry, and list it under a profile.

### Theming: three flavors, one active

Flavors are `morok`, `popil`, `vatra`; `popil` is currently active. Every themed tool has **all three flavors vendored side by side** under `dotfiles/.config/<tool>/themes/`, and a loader line elsewhere picks one. Sync writes the flavor files; `set_flavor.py` rewrites the loaders. These are strictly separate steps.

`scripts/set_flavor.py` handles four categories, and any new themed tool must be added to the right one:

1. **Regex swap in a loader line** - `starship.toml` (`palette = `), `helix/config.toml` (`theme = `), `zellij/config.kdl`, `k9s/config.yaml` (`skin: `), `bat/config` (`--theme=`), `ghostty/config` (`theme = <f>.conf`), `.gitconfig` (`[delta] features = `), `zed/settings.json` (`theme.light` + `theme.dark`), `fish/config.fish` (`fish_config theme choose`), `fish/fzf.fish` (`themes/fzf-<f>.fish` + `$FZF_<F>`)
2. **Whole file copied from `themes/<flavor>.<ext>`** - `bottom/bottom.toml`, `fastfetch/config.jsonc`. These configs are *only* theme, so they are replaced wholesale; never hand-edit them, edit the vendored flavor file
3. **Spliced block** - `lazygit/config.yml`, where the surrounding config is hand-maintained so only the `gui.theme:` block is replaced from `lazygit/themes/<flavor>.yml`, and `herdr/config.toml`, where everything above the `# == Keys ==` banner is replaced from `herdr/themes/<flavor>.toml` and the `[keys]` block below it is hand-maintained
4. **Path rewrite in `dotdrop.config.yaml`** - Zen ships a directory per flavor (`.config/zen/<flavor>/userC*.css`), so the flavor lives in the `src:` path, not inside the file

Two configs cannot include an external palette, so both carry all three inline: `starship.toml` has `[palettes.morok|popil|vatra]` blocks spliced in by sync with `palette = "<flavor>"` choosing; `.gitconfig` includes all three `delta/themes/<flavor>.gitconfig` files with `[delta] features` choosing.

Tools whose theme is picked by their own UI or CLI are outside `set-flavor`: Spicetify (`just spicetify <flavor>`), Obsidian (appearance settings), Stylus, Telegram, Discord/Vesktop, VSCode. Sync still drops every flavor file into place for them.

After `just set-flavor`, run `just dotfiles` to deploy.

### Shell: fish

`dotfiles/.config/fish/config.fish` is the entry point: initializes fzf, pyenv, starship, zoxide; sources `aliases.fish`, `exports.fish`, `fzf.fish`, `functions.fish`, `vimode.fish`; then optionally `local.fish` and `.secrets.fish` (untracked, machine-local); then picks the fish theme. `exports.fish` uses `set -Ux` (universal + exported) - values persist in fish's universal variable store, so removing a line here does not unset it on an already-configured machine.

### Claude Code config

`dotfiles/.claude/` holds only `settings.json` and `statusline-command.sh`. The global rules are **not** in this repository: they live as instruction files in `pivoshenko/pivoshenko.ai` under `instructions/` and sync into `~/.claude/CLAUDE.md` via Kasetto, along with skills and MCP servers.

`settings.json` carries a `hooks.SessionStart` entry that runs herdr's agent-state hook, which is what lets the herdr sidebar report whether Claude is working, blocked, or idle. The hook *script* is herdr-managed and deliberately untracked - `herdr integration install claude` writes it to `~/.claude/hooks/herdr-agent-state.sh` and overwrites it on every update, so `just herdr-integration` restores it on a new machine.

herdr plugins install into `~/.config/herdr/plugins/`, which is runtime state and therefore untracked - only `config.toml` is mapped. `just herdr-plugins` reinstalls them on a new machine; their `[[keys.command]]` bindings live in `config.toml` and are tracked. Note that `herdr server reload-config` does *not* validate plugin action ids: a binding naming a plugin that isn't installed reloads clean and simply does nothing.

The `command` string must stay byte-identical to what herdr writes, absolute path and inner quotes included. herdr matches on that exact string to decide the hook is already present; rewrite it to `~/.claude/...` and herdr stops recognizing it and appends a second copy, so the hook fires twice.

## Conventions

- `.editorconfig`: UTF-8, LF, 2-space indent (4 for Python and Rust), 120-char lines, trailing whitespace trimmed, final newline
- Config files use `# == Section ==` banner comments for grouping (`Brewfile`, fish configs, `dotdrop.config.yaml`, the scripts)
- Prose, comments, and commit messages say "repository", never "repo"
- Python module docstrings open with `Module that contains ...`; `__init__.py` with `Package that contains ...`
- Commits follow Angular conventional commits with a tool-named scope where it applies (`feat(fish):`, `docs(readme):`, `feat(brew):`)
- JetBrains Mono Nerd Font everywhere
- Vendored theme files under any `themes/` directory are generated by sync - fix them in `pivoshenko.theme` and re-sync, do not patch them here
