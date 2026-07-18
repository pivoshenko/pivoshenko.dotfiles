# pivoshenko.dotfiles

<p align="left">
  <a href="https://stand-with-ukraine.pp.ua/">
    <img alt="StandWithUkraine" src="https://img.shields.io/badge/Support-Ukraine-FFC93C?style=flat-square&labelColor=07689F">
  </a>
</p>

## Overview

My personal dotfiles. The whole thing leans on three ideas: keep it minimal, keep it consistent, and make every tool look like it belongs to the same family. What's here:

- Brew dependencies — apps, fonts, LSPs, extensions — in [`Brewfile`](Brewfile)
- Apps and tools config — in [`dotfiles/.config/`](dotfiles/.config)
- [Claude Code](https://claude.com/claude-code) setup — `settings.json`, statusline — in [`dotfiles/.claude/`](dotfiles/.claude) (global rules sync via Kasetto, see below)
- Git, SSH, GPG — [`.gitconfig`](dotfiles/.gitconfig), [`.ssh/`](dotfiles/.ssh), [`.gnupg/`](dotfiles/.gnupg)

## Main principles

- Minimalism, consistency, simplicity
- One unified look via [pivoshenko.theme](https://github.com/pivoshenko/pivoshenko.theme). Right now I'm running **Popil** (warm ash, muted terracotta). **Morok** (pitch black, cool accents) and **Vatra** (Carpathian hearth, gruvbox-warm) are vendored alongside it
- [JetBrains Mono](https://www.jetbrains.com/lp/mono), everywhere

To switch flavors: `just set-flavor <morok|popil|vatra>`, then `just dotfiles`.

## Installation

Everything is managed with [dotdrop](https://github.com/deadc0de6/dotdrop) and driven through [just](https://github.com/casey/just).

1. Fork and clone this repository
2. Install everything:

```shell
just install
```

That runs `brew bundle` and deploys both dotdrop profiles. Need only one half? `just brew` or `just dotfiles`. Run `just` on its own to see every recipe.

> [!NOTE]
> A couple of apps still want a manual step — **Telegram** and **Discord**, where the theme installs through each app's own UI. The relevant sections below spell out what to do.

## Terminal — Ghostty

[Ghostty](https://ghostty.org) — a fast, GPU-accelerated, native macOS terminal from Mitchell Hashimoto. It's the first terminal in years that feels designed rather than accreted. No perceptible latency, and a config format that reads cleanly. Config: [`dotfiles/.config/ghostty`](dotfiles/.config/ghostty).

## Shell — Fish

[Fish](https://fishshell.com) comes with the good stuff already on: autosuggestions, syntax highlighting, and scripting that doesn't drag along bash's compatibility baggage. I run it with a handful of plugins through [Fisher](https://github.com/jorgebucaran/fisher). Config: [`dotfiles/.config/fish`](dotfiles/.config/fish).

Prompt is [Starship](https://starship.rs) — one binary, one TOML file, works in every shell, and fast enough that I stop noticing it. Config: [`dotfiles/.config/starship.toml`](dotfiles/.config/starship.toml).

### CLI Tools

The tools I reach for every day, all configured under [`.config/`](dotfiles/.config):

- [Bat](https://github.com/sharkdp/bat) — `cat` with syntax highlighting and git gutters. Hard to go back once you've used it
- [Bottom](https://github.com/ClementTsang/bottom) — `htop` rethought: keyboard-driven, themable, readable on a wide monitor
- [Delta](https://github.com/dandavison/delta) — makes `git diff` pleasant to read instead of a squinting exercise
- [Eza](https://github.com/eza-community/eza) — a modern `ls` with icons, git status, and a tree mode that handles big repositories fine
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch) — fast, configurable, JSONC-driven system fetch
- [Fd](https://github.com/sharkdp/fd) — `find` with sane defaults and far less typing
- [Fzf](https://github.com/junegunn/fzf) — fuzzy-finds everything and plugs into everything. If I could keep one CLI tool, this is it
- [Ripgrep](https://github.com/BurntSushi/ripgrep) — very fast grep that respects `.gitignore` out of the box
- [K9s](https://github.com/derailed/k9s) — a Kubernetes UI that keeps me out of `kubectl get pods | grep`
- [LazyGit](https://github.com/jesseduffield/lazygit) — staging, rebases, and cherry-picks at TUI speed. It replaced every GUI git client I used to run
- [LazyDocker](https://github.com/jesseduffield/lazydocker) — the same idea as LazyGit, pointed at containers and compose stacks
- [Zellij](https://github.com/zellij-org/zellij) — `tmux` with a discoverable UI and defaults I don't have to fight
- [Zoxide](https://github.com/ajeetdsouza/zoxide) — a smarter `cd` that learns the directories you actually use. Type `z foo` and you're there

## Editors

### Editor — Helix

[Helix](https://helix-editor.com) is my primary CLI editor, and I keep moving more day-to-day work into it. Its selection-first modal model (selection then action, à la Kakoune) clicked for me in a way Vim's verb-object grammar never quite did. Multiple cursors and tree-sitter selections feel native rather than bolted on, and LSP works without a plugin scavenger hunt. Config: [`dotfiles/.config/helix`](dotfiles/.config/helix).

### Editor — Zed

[Zed](https://zed.dev) is my daily editor. It's Rust-native, GPU-accelerated, and collaborative, and it ships Vim, Helix, and Whichkey modes in the box instead of leaving them to third-party plugins. Config: [`dotfiles/.config/zed/settings.json`](dotfiles/.config/zed/settings.json).

## Agentic Coding — Claude Code

[Claude Code](https://claude.com/claude-code) is my coding assistant. Config (`settings.json` plus a custom statusline): [`dotfiles/.claude`](dotfiles/.claude).

Skills, MCPs, and instructions (the global `CLAUDE.md` / `AGENTS.md` rules) are distributed across hosts with [Kasetto](https://www.kasetto.dev/). The Kasetto config lives in [`pivoshenko/pivoshenko.ai`](https://github.com/pivoshenko/pivoshenko.ai), with personal and external sources both included.

The global rules used to be a single `CLAUDE.md` in this repository. They now live as individual instruction files in [`pivoshenko.ai/instructions`](https://github.com/pivoshenko/pivoshenko.ai/tree/main/instructions), with a structure loosely inspired by *Andrej Karpathy's CLAUDE.md*.

## macOS

### Hotkeys Daemon — Karabiner

I drive as much as I can from the keyboard, with Vi/Kakoune motions. Where macOS or the window manager won't cooperate, [Karabiner](https://github.com/pqrs-org/Karabiner-Elements) covers the gap. It's built around [home row mods](https://precondition.github.io/home-row-mods), following this [guide](https://havn.blog/2024/03/03/a-good-way.html).

Config: [`dotfiles/.config/karabiner/karabiner.json`](dotfiles/.config/karabiner/karabiner.json).

### Tiling Window Manager — Rectangle

[Rectangle](https://rectangleapp.com/) gives me i3-style tiling on macOS. I tried yabai and Aerospace first; Rectangle won on the boring but decisive point of surviving every macOS update without any SIP gymnastics. Config: [`dotfiles/.config/rectangle/config.json`](dotfiles/.config/rectangle/config.json).

## Browser — Zen

[Zen](https://zen-browser.app) is a Firefox fork that ships the browser experience I'd been hand-rolling with userChrome hacks for years: keyboard-driven, vertical tabs, minimal chrome. Extensions:

- [Custom New Tab](https://addons.mozilla.org/en-US/firefox/addon/custom-new-tab-page) — sends new tabs to my own [startpage](https://startpage.pivoshenko.dev) instead of Mozilla's default
- [DuckDuckGo](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox) — my default search
- [MetaMask](https://addons.mozilla.org/en-US/firefox/addon/ether-metamask) — Ethereum/EVM wallet, the one every dapp assumes you already have
- [NordPass](https://addons.mozilla.org/en-US/firefox/addon/nordpass-password-management) — password manager I've stuck with for years; the autofill stays out of the way
- [NordVPN](https://addons.mozilla.org/en-US/firefox/addon/nordvpn-proxy-extension) — same family, same story
- [Obsidian Web Clipper](https://addons.mozilla.org/en-US/firefox/addon/web-clipper-obsidian) — clips articles straight into the vault as clean Markdown, no copy-paste dance
- [Phantom](https://addons.mozilla.org/en-US/firefox/addon/phantom-app) — Solana-first multichain wallet; cleaner UX than MetaMask when I'm off EVM
- [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17) — EFF's heuristic tracker blocker, which pairs well with uBlock without stepping on it
- [RaindropIo](https://addons.mozilla.org/en-US/firefox/addon/raindropio) — bookmarks with tags, collections, and a UI I don't mind opening
- [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us) — userstyles, minus the abandonware history of Stylish
- [uBlock](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin) — the ad blocker. Thank you, Raymond Hill
- [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff) — keyboard navigation on every page; once `f` follows a link for you, the mouse feels slow

`userChrome.css` / `userContent.css` live in [`dotfiles/.config/zen`](dotfiles/.config/zen) and deploy into the active profile's [`chrome/` subfolder](https://www.userchrome.org).

Per-site styling is handled by [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us). The userstyles export to [`dotfiles/.config/stylus`](dotfiles/.config/stylus) and get imported through the extension's preferences.

## Notes — Obsidian

I keep my notes in [Obsidian](https://obsidian.md): local-first, plain Markdown on disk, no lock-in, and a plugin ecosystem that covers what I'd otherwise reach for Notion for. The vault syncs over iCloud. Vendored themes and snippets in [`dotfiles/.config/obsidian`](dotfiles/.config/obsidian) deploy via the `me` profile into `<vault>/.obsidian/{themes,snippets}/`; the vault path is machine-specific and set in [`dotdrop.config.yaml`](dotdrop.config.yaml). The active theme is chosen inside Obsidian's appearance settings.

Plugins:

- [Obsidian Images in-editor](https://github.com/ozntel/oz-image-in-editor-obsidian) — inline image previews in source mode, so I stop flipping to preview
- [Obsidian Tag Wrangler](https://github.com/pjeby/tag-wrangler) — rename and merge tags without a grep-and-replace across the vault
- [Obsidian Outliner](https://github.com/vslinko/obsidian-outliner) — bullet handling that behaves like Workflowy or Roam
- [Obsidian Style Settings](https://github.com/mgmeyers/obsidian-style-settings) — surfaces theme variables in the UI so I'm not editing CSS to change an accent

## Music — Spotify

Spotify is customized through [Spicetify](https://github.com/spicetify/cli). Themes live in [`dotfiles/.config/spicetify/Themes`](dotfiles/.config/spicetify/Themes); activate a flavor with `just spicetify <morok|popil|vatra>`.

## Messengers

### Messenger — Telegram

[Telegram](https://telegram.org) with my Popil theme, installed from [t.me/addtheme/pivoshenko_theme_popil](https://t.me/addtheme/pivoshenko_theme_popil).

### Messenger — Discord

The official Discord client is missing too much for me, so I run [Vesktop](https://github.com/Vencord/Vesktop) instead. Install the Popil theme through *Themes → Online Themes*:

```css
@dark https://raw.githubusercontent.com/pivoshenko/pivoshenko.theme/refs/heads/main/dist/discord/popil.theme.css
```

## Other Apps

- [f.lux](https://justgetflux.com) — warms the display after sunset; I notice right away on a machine that doesn't have it
- [NordPass](https://nordpass.com) / [NordVPN](https://nordvpn.com) — a password manager and a VPN I've run for years without having to think about either. That's the whole point
- [DBeaver](https://dbeaver.io) — one client for every database I touch. The Eclipse bones are ugly, but it handles Postgres, MySQL, SQLite, and Mongo without me hunting down a vendor GUI for each
- [Tailscale](https://tailscale.com) — WireGuard with the setup pain removed. My NAS, work boxes, and phone all sit on one flat network, and I haven't touched VPN config in years
- [Maccy](https://maccy.app) — clipboard-history manager: lightweight, keyboard-driven, and out of the way until I hit the hotkey
- [Logi Options+](https://www.logitech.com/software/logi-options-plus.html) — per-app buttons and gestures for the Logitech mouse, which is what finally makes the extra thumb buttons worth having
- [Docker Desktop](https://www.docker.com/products/docker-desktop) — the container runtime everything else assumes; LazyDocker just drives what it provides
