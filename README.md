# pivoshenko.dotfiles

<p align="left">
  <a href="https://stand-with-ukraine.pp.ua/">
    <img alt="StandWithUkraine" src="https://img.shields.io/badge/Support-Ukraine-FFC93C?style=flat-square&labelColor=07689F">
  </a>
</p>

## Overview

Personal dotfiles focused on minimalism, consistency, and cross-tool theming, bundling:

- Brew dependencies — apps, fonts, LSPs, extensions — in [`Brewfile`](Brewfile)
- Apps and tools config — in [`dotfiles/.config/`](dotfiles/.config)
- [Claude Code](https://claude.com/claude-code) setup — `settings.json`, statusline — in [`dotfiles/.claude/`](dotfiles/.claude) (global rules now sync via Kasetto, see below)
- Git, SSH, GPG — [`.gitconfig`](dotfiles/.gitconfig), [`.ssh/`](dotfiles/.ssh), [`.gnupg/`](dotfiles/.gnupg)

## Main principles

- Minimalism, consistency, simplicity
- Unified style via [pivoshenko.theme](https://github.com/pivoshenko/pivoshenko.theme) — currently running **Popil** (warm ash, muted terracotta). **Morok** (pitch black, cool accents) and **Vatra** (Carpathian hearth, gruvbox-warm) are also vendored
- Typography: [JetBrains Mono](https://www.jetbrains.com/lp/mono) everywhere

Swap flavors with `just set-flavor <morok|popil|vatra>` followed by `just dotfiles`.

## Installation

Dotfiles are managed via [dotdrop](https://github.com/deadc0de6/dotdrop) and driven through [just](https://github.com/casey/just).

1. Fork and clone this repository
2. Install everything:

```shell
just install
```

This runs `brew bundle` and deploys both dotdrop profiles. Use `just brew` or `just dotfiles` to run halves separately; `just` lists every recipe.

> [!NOTE]
> A few apps still need a manual step — currently **Telegram** and **Discord** (theme install through each app's own UI). Each section below documents what to do.

## Terminal — Ghostty

[Ghostty](https://ghostty.org) — fast, GPU-accelerated, native macOS terminal from Mitchell Hashimoto. The first terminal in years that feels like it was designed end-to-end rather than evolved by accretion; zero perceptible latency and a config format that doesn't insult the reader. Config: [`dotfiles/.config/ghostty`](dotfiles/.config/ghostty).

## Shell — Fish

[Fish](https://fishshell.com) ships batteries-included — autosuggestions, syntax highlighting, and sane scripting without the bash compatibility tax. Plugins are managed via [Fisher](https://github.com/jorgebucaran/fisher) — only a few installed. Config: [`dotfiles/.config/fish`](dotfiles/.config/fish).

Prompt: [Starship](https://starship.rs) — single binary, single TOML, works in every shell; fast enough that I forget it's there. Config: [`dotfiles/.config/starship.toml`](dotfiles/.config/starship.toml).

### CLI Tools

Daily-driver CLI tools (all configured under [`.config/`](dotfiles/.config)):

- [Bat](https://github.com/sharkdp/bat) — `cat` with syntax highlighting and git gutters; the drop-in I never want to live without
- [Bottom](https://github.com/ClementTsang/bottom) — `htop` reimagined: keyboard-driven, themable, and actually readable on a wide monitor
- [Delta](https://github.com/dandavison/delta) — turns `git diff` into something I read for fun instead of squinting at
- [Eza](https://github.com/eza-community/eza) — modern `ls` with icons, git status, and tree mode that doesn't choke on big repositories
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch) — the only fetch tool worth the screen real estate; fast, configurable, JSONC-driven
- [Fd](https://github.com/sharkdp/fd) — `find` with sane defaults and an order of magnitude less typing
- [Fzf](https://github.com/junegunn/fzf) — the single CLI tool I'd save from a fire; fuzzy-finds everything, integrates everywhere
- [Ripgrep](https://github.com/BurntSushi/ripgrep) — fastest grep on the planet, respects `.gitignore` by default
- [K9s](https://github.com/derailed/k9s) — the only Kubernetes UI that keeps me out of `kubectl get pods | grep` purgatory
- [LazyGit](https://github.com/jesseduffield/lazygit) — interactive staging, rebases, and cherry-picks at TUI speed; replaced every GUI client for me
- [LazyDocker](https://github.com/jesseduffield/lazydocker) — same magic as LazyGit, applied to containers and compose stacks
- [Zellij](https://github.com/zellij-org/zellij) — `tmux` with a discoverable UI and sane defaults out of the box
- [Zoxide](https://github.com/ajeetdsouza/zoxide) — smarter `cd` that learns where you actually live; `z foo` and you're there

The complete list of installed CLI tools is in the [`Brewfile`](Brewfile).

## Editors

### Editor — Helix

[Helix](https://helix-editor.com) — primary CLI editor; gradually moving day-to-day work to it. The selection-first modal model (selection → action, à la Kakoune) is, in my opinion, a real step up from Vim's verb-object grammar — multiple cursors and tree-sitter selections feel native instead of bolted on, and the batteries-included LSP setup means zero plugin yak-shaving. Config: [`dotfiles/.config/helix`](dotfiles/.config/helix).

### Editor — Zed

[Zed](https://zed.dev) — daily editor. Rust-native, GPU-accelerated, collaborative — and unlike most "modern" editors it actually ships Vim, Helix, and Whichkey modes out of the box instead of leaving them to flaky plugins. Config: [`dotfiles/.config/zed/settings.json`](dotfiles/.config/zed/settings.json).

## Agentic Coding — Claude Code

[Claude Code](https://claude.com/claude-code) is my coding assistant. Config (`settings.json` + custom statusline): [`dotfiles/.claude`](dotfiles/.claude).

Skills, MCPs, and instructions (the global `CLAUDE.md` / `AGENTS.md` rules) are distributed across hosts via [Kasetto](https://www.kasetto.dev/). The Kasetto config lives in [`pivoshenko/pivoshenko.ai`](https://github.com/pivoshenko/pivoshenko.ai) — personal and external sources both included.

The global rules — formerly a single `CLAUDE.md` in this repo — now live as individual instruction files in [`pivoshenko.ai/instructions`](https://github.com/pivoshenko/pivoshenko.ai/tree/main/instructions); their structure was inspired by *Andrej Karpathy's CLAUDE.md*.

## macOS

### Hotkeys Daemon — Karabiner

I drive everything from the keyboard via Vi/Kakoune motions. Where macOS or the window manager doesn't support that, [Karabiner](https://github.com/pqrs-org/Karabiner-Elements) fills the gap — built around [home row mode](https://precondition.github.io/home-row-mods) following this [guide](https://havn.blog/2024/03/03/a-good-way.html).

Config: [`dotfiles/.config/karabiner/karabiner.json`](dotfiles/.config/karabiner/karabiner.json).

### Tiling Window Manager — Rectangle

[Rectangle](https://rectangleapp.com/) replicates i3-style tiling on macOS. Tried yabai and Aerospace; Rectangle wins on the "just works after every macOS update, no SIP gymnastics" axis. Config: [`dotfiles/.config/rectangle/config.json`](dotfiles/.config/rectangle/config.json).

## Browser — Zen

[Zen](https://zen-browser.app) — a Firefox fork that finally gives the browser the keyboard-driven, vertical-tabs, minimal-chrome UX I've been bolting on with userChrome hacks for years. Extensions:

- [Custom New Tab](https://addons.mozilla.org/en-US/firefox/addon/custom-new-tab-page) — points new tabs at my own [startpage](https://startpage.pivoshenko.dev) instead of Mozilla's noisy default
- [DuckDuckGo](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox) — default search; Google's results just aren't worth the tracking anymore
- [MetaMask](https://addons.mozilla.org/en-US/firefox/addon/ether-metamask) — Ethereum/EVM wallet; the one every dapp assumes you already have
- [NordPass](https://addons.mozilla.org/en-US/firefox/addon/nordpass-password-management) — password manager I've stuck with for years; the autofill genuinely stays out of the way
- [NordVPN](https://addons.mozilla.org/en-US/firefox/addon/nordvpn-proxy-extension) — same family, same story; never had to think about it, which is the highest praise I give a VPN
- [Obsidian Web Clipper](https://addons.mozilla.org/en-US/firefox/addon/web-clipper-obsidian) — clips articles straight into the vault as clean Markdown, no copy-paste dance
- [Phantom](https://addons.mozilla.org/en-US/firefox/addon/phantom-app) — Solana-first multichain wallet; cleaner UX than MetaMask when I'm off EVM
- [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17) — EFF's heuristic tracker blocker; pairs nicely with uBlock without overlapping
- [RaindropIo](https://addons.mozilla.org/en-US/firefox/addon/raindropio) — bookmarks that don't feel like bookmarks; tags, collections, and a UI I actually want to revisit
- [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us) — userstyles without the abandoned-extension drama of Stylish
- [uBlock](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin) — the only ad blocker; the rest are noise. Thank you, Raymond Hill
- [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff) — keyboard navigation everywhere; once you've used `f` to follow a link, the mouse feels broken

`userChrome.css` / `userContent.css` live in [`dotfiles/.config/zen`](dotfiles/.config/zen) and deploy into the active profile's [`chrome/` subfolder](https://www.userchrome.org).

Per-site styling uses [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us) — userstyles export at [`dotfiles/.config/stylus`](dotfiles/.config/stylus), imported via the extension's preferences.

## Notes — Obsidian

[Obsidian](https://obsidian.md) for notes — local-first, plain Markdown on disk, no lock-in, and the plugin ecosystem covers anything Notion does without the SaaS tax. Vault synced through iCloud. Vendored themes + snippets in [`dotfiles/.config/obsidian`](dotfiles/.config/obsidian) deploy via the `me` profile into `<vault>/.obsidian/{themes,snippets}/` — the vault path is machine-specific (set in [`dotdrop.config.yaml`](dotdrop.config.yaml)). Active theme is picked inside Obsidian's appearance settings.

Plugins:

- [Obsidian Admonition](https://github.com/javalent/admonitions) — styled callout/admonition blocks (notes, warnings, tips) that survive as plain Markdown
- [Obsidian Images in-editor](https://github.com/ozntel/oz-image-in-editor-obsidian) — inline image previews in source mode so I don't have to keep flipping to preview
- [Obsidian Tag Wrangler](https://github.com/pjeby/tag-wrangler) — rename and merge tags without grep-and-replace across the vault
- [Obsidian Outliner](https://github.com/vslinko/obsidian-outliner) — bullet handling that finally behaves like Workflowy / Roam
- [Obsidian Style Settings](https://github.com/mgmeyers/obsidian-style-settings) — exposes theme variables in the UI so I'm not editing CSS every time I want a different accent

## Music — Spotify

Spotify is customised via [Spicetify](https://github.com/spicetify/cli). Themes live in [`dotfiles/.config/spicetify/Themes`](dotfiles/.config/spicetify/Themes) — activate a flavor with `just spicetify <morok|popil|vatra>`.

## Messengers

### Messenger — Telegram

[Telegram](https://telegram.org) with my Popil theme — installed via [t.me/addtheme/pivoshenko_theme_popil](https://t.me/addtheme/pivoshenko_theme_popil).

### Messenger — Discord

The official Discord client lacks functionality, so I run [Vesktop](https://github.com/Vencord/Vesktop) instead. Install the Popil theme via *Themes → Online Themes*:

```css
@dark https://raw.githubusercontent.com/pivoshenko/pivoshenko.theme/refs/heads/main/dist/discord/popil.theme.css
```

## Other Apps

- [f.lux](https://justgetflux.com) — warms the display after sunset; my eyes notice immediately when I'm on a machine without it
- [NordPass](https://nordpass.com) / [NordVPN](https://nordvpn.com) — boring, reliable, and that's exactly what I want from a password manager and a VPN. Been on both for years
- [DBeaver](https://dbeaver.io) — one client for every database I touch; ugly Eclipse bones, but it's the only tool that handles Postgres, MySQL, SQLite, and Mongo without me hunting for vendor GUIs
- [Tailscale](https://tailscale.com) — WireGuard with the UX problem solved; my home NAS, work boxes, and phone are all on one flat network and I haven't thought about VPN config in years
- [Maccy](https://maccy.app) — clipboard-history manager; lightweight, keyboard-driven, and out of the way until I hit the hotkey
- [Logi Options+](https://www.logitech.com/software/logi-options-plus.html) — per-app buttons and gestures for the Logitech mouse; the only reason the extra thumb buttons earn their keep
- [Docker Desktop](https://www.docker.com/products/docker-desktop) — the container runtime everything else assumes; LazyDocker just drives what it provides
