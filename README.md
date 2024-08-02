# pivoshenko's dotfiles

<p align="center">
  <a href="https://stand-with-ukraine.pp.ua/">
    <img alt="standwithukraine" src="https://img.shields.io/badge/Support-Ukraine-FFC93C?style=flat-square&labelColor=07689F">
  </a>
  <a href="https://stand-with-ukraine.pp.ua">
    <img alt="standwithukraine" src="https://img.shields.io/badge/made_in-Ukraine-FFC93C.svg?style=flat-square&labelColor=07689F">
  </a>
</p>

> [!CAUTION]
> Currently, my dotfiles are under heavy redesign so this README and configs are a bit outdated.

## Overview

What's in here?

- My `brew` dependencies, including apps, fonts, LSPs, extensions, etc., see [`Brewfile`](Brewfile)
- My macOS default configurations, see [`macos/`](macos/defaults.sh)
- My wallpapers set, see [`wallpapers/`](wallpapers)
- My configurations for the apps, see [`.config/`](dotfiles/.config)

## Main principles

- Minimalism in everything
- Consistency
- Simplicity
- One style
  - [JetBrains Mono Font](https://www.jetbrains.com/lp/mono)
  - [Catppuccin Macchiato Mauve](https://github.com/catppuccin/catppuccin) color palette
- Reduced visual noise, only important things should be shown

## Installation

I am using [`dotdrop`](https://github.com/deadc0de6/dotdrop) to manage dotfiles. Steps:

1. Clone this repo with: `git clone https://github.com/pivoshenko/dotfiles dotfiles`
2. `cd dotfiles/`
3. Run the following commands to install the necessary tooling:

```shell
dotdrop install -c dotdrop.config.yaml -p macos --force
```

## Apps

I am using [`brew`](https://brew.sh) to install both GUI and CLI applications. Resulting [`Brewfile`](Brewfile) contains everything.

### Tiling Window Manager

I use [`AeroSpace`](https://github.com/nikitabobko/AeroSpace) as a tiling window manager for macOS, which essentially replicates `i3` functionality.

My configuration can be found [here](dotfiles/.config/aerospace/aerospace.toml). The core idea is to define the following workspaces and bind relevant applications to them:

- #1 Comms (Telegram, Discord, etc.)
- #2 Media
- #3 Notes (Obsidian)
- #4 Browsing (Zen)
- #5 Terminal (iTerm2)
- #6 Coding (Zed, VSCode)
- #7 Databases (MongoDB Compass, DBeaver)
- #8 Misc (Insomnia, Postman)
- #9 Misc

Some applications, typically used in "quick pop-up" mode, follow a **floating layout** and are not bound to any workspace.

Additionally, workspaces are integrated with [`SketchyBar`](https://github.com/FelixKratz/SketchyBar) for better visibility and interaction.
