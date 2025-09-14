# pivoshenko's dotfiles

![](https://raw.githubusercontent.com/pivoshenko/dotfiles/main/assets/preview.png)

<p align="center">
  <a href="https://stand-with-ukraine.pp.ua/">
    <img alt="standwithukraine" src="https://img.shields.io/badge/Support-Ukraine-FFC93C?style=flat-square&labelColor=07689F">
  </a>
  <a href="https://stand-with-ukraine.pp.ua">
    <img alt="standwithukraine" src="https://img.shields.io/badge/made_in-Ukraine-FFC93C.svg?style=flat-square&labelColor=07689F">
  </a>
</p>

- [pivoshenko's dotfiles](#pivoshenkos-dotfiles)
  - [Overview](#overview)
  - [Main principles](#main-principles)
  - [Usage](#usage)
  - [macOS](#macos)
  - [CLI](#cli)
    - [Helix](#helix)
    - [fzf](#fzf)
  - [Applications](#applications)
    - [Application Launcher - Raycast](#application-launcher---raycast)
    - [Hotkeys Daemon - Karabiner](#hotkeys-daemon---karabiner)
    - [Tiling Window Manager - Aerospace](#tiling-window-manager---aerospace)
    - [Editors](#editors)
      - [Editors - VSCode](#editors---vscode)
      - [Editors - Zed](#editors---zed)
    - [Browser - Zen](#browser---zen)
    - [Notes - Obsidian](#notes---obsidian)
    - [Music - Spotify](#music---spotify)
    - [Messengers](#messengers)
      - [Messengers - Telegram](#messengers---telegram)
      - [Messengers - Discord](#messengers---discord)
    - [Honourable Mentions](#honourable-mentions)

> [!NOTE]
> For some applications, there is no easy way to save the config in the dotfiles, so it requires a bit of manual work. Please read the README to find out about them.

## Overview

What's in here?

- My `brew` dependencies, including apps, fonts, LSPs, extensions, etc., see [`Brewfile`](Brewfile)
- My macOS default configurations, see [`macos/`](macos/defaults.sh)
- My wallpapers, see [`wallpapers/`](https://github.com/pivoshenko/wallpapers)
- My configs, see [`.config/`](dotfiles/.config)

## Main principles

- Minimalism in all aspects
- Consistency throughout the configuration
- Simplicity in design and configuration
- Unified style [Catppuccin theme](https://github.com/catppuccin/catppuccin) and [JetBrains Mono font](https://www.jetbrains.com/lp/mono)

## Usage

I am using [`dotdrop`](https://github.com/deadc0de6/dotdrop) to manage dotfiles.

1. Fork this repository and clone it
2. Run the following commands to install the necessary tooling:

```shell
brew bundle
```

3. Run the following commands to install the dotfiles:

```shell
dotdrop install -c dotdrop.config.yaml -p default --force
dotdrop install -c dotdrop.config.yaml -p macos --force
```

## macOS

To configure macOS I am using [`defaults`](https://macos-defaults.com), my configuration can be found [here](macos/defaults.sh).

Run the following commands to configure macOS defaults:

```shell
sudo sh macos/defaults.sh
```

## Shell

I am using [iTerm2](https://iterm2.com) as my main terminal with the [Catppuccin](https://github.com/catppuccin/iterm) theme applied. My configuration can be found [here](dotfiles/.config/iterm2).

For the shell, I am using [Fish](https://fishshell.com), as out of the box it has all batteries included. To manage shell plugins, I am using [Fisher](https://github.com/jorgebucaran/fisher), but there are only a few installed. My complete configuration can be found [here](dotfiles/.config/fish).

In terms of command-line tools, I try to keep them minimal—only the ones I use daily, such as:

- [`bat`](https://github.com/sharkdp/bat)
- [`bottom`](https://github.com/ClementTsang/bottom)
- [`delta`](https://github.com/dandavison/delta)
- [`exa`](https://github.com/ogham/exa)
- [`fd`](https://github.com/sharkdp/fd)
- [`fzf`](https://github.com/junegunn/fzf)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- [`k9s`](https://github.com/derailed/k9s)
- [`lazygit`](https://github.com/jesseduffield/lazygit)
- [`lazydocker`](https://github.com/jesseduffield/lazydocker)
- [`yazi`](https://github.com/sxyazi/yazi)
- [`zellij`](https://github.com/zellij-org/zellij)
- [`zoxide`](https://github.com/ajeetdsouza/zoxide)

A complete list of configurations for each tool can be found in the [`.config`](dotfiles/.config) directory.

### Helix

I use [Helix](https://helix-editor.com) as my main editor for CLI, and I am trying to move all my day-to-day work to it. My configuration can be found [here](dotfiles/.config/helix).
I want to highlight it separately, as it's a truly amazing editor with a lot of features and very handy keybindings out of the box.

### fzf

Another highlight is [fzf](https://github.com/junegunn/fzf), which I heavily use for autocompletion and fuzzy search in the shell. I can't imagine my workflow without it.

## Applications

I am using [Homebrew](https://brew.sh) to install both GUI applications and command-line tools. You can find a list of all applications, as well as LSPs and VSCode plugins, in the [`Brewfile`](Brewfile).

### Application Launcher - Raycast

I recently moved from the default macOS Spotlight to [Raycast](https://www.raycast.com). While it offers an impressive range of features and a sleek user experience, many of its advanced capabilities are locked behind a Pro subscription, which I find limiting. As a result, I'm currently exploring alternative solutions.

### Hotkeys Daemon - Karabiner

I primarily use an external keyboard, and in most of my apps, I rely on either Vi/Kakoune motions. I find it painful to use the mouse, as it requires moving my right hand off the keyboard and distracts my "zen" state. In most of the dev apps, you can enable such modes, but in the default macOS apps or window manager, such functionality is absent. To resolve this issue, I am using [Karabiner](https://github.com/pqrs-org/Karabiner-Elements).

My configuration can be found [here](dotfiles/.config/karabiner/karabiner.json). The main idea is to implement [home row mode](https://precondition.github.io/home-row-mods) using this [guide](https://havn.blog/2024/03/03/a-good-way.html).

### Tiling Window Manager - Aerospace

I use [AeroSpace](https://github.com/nikitabobko/AeroSpace) as a tiling window manager for macOS, which essentially replicates i3 functionality.

My configuration can be found [here](dotfiles/.config/aerospace/aerospace.toml). The main idea is to define the following workspaces and bind relevant applications to them:

- #1 Comms: Telegram, Discord, etc
- #2 Media: Spotify, Music, etc.
- #3 Notes: Obsidian, etc.
- #4 Browsing: Zen, Chrome, etc.
- #5 Terminal: iTerm2
- #6 Coding: Zed, VSCode, Cursor, etc.
- #7 Databases: MongoDB Compass, DBeaver, etc.
- #8 APIs: Insomnia, Postman etc.
- #9 Misc

Some applications, typically used in "quick pop-up" mode (e.g., macOS default apps), follow a **floating layout** and are not bound to any workspace.

### Editors

#### Editors - VSCode

I absolutely love [VSCode](https://code.visualstudio.com) - it's a simple and yet very extensible and powerful editor.

Here's a list of [extensions](Brewfile) I use daily, but I try to keep my `VSCode` setup as simple as possible. It was also heavily influenced by [`makevscodeawesome`](https://makevscodeawesome.com).

My VSCode configuration can be found [here](dotfiles/vscode/settings.json).

#### Editors - Zed

Despite my love for VSCode, it still has limitations and I like to explore new tools, so currently I am trying to move my day-to-day work to [Zed](https://zed.dev), which I think, as an editor, has a bright future. I personally like how it can be configured and the way plugins are installed.

My Zed plugins and configuration can be found [here](dotfiles/.config/zed/settings.json).

### Browser - Zen

As a browser, I am using [Zen](https://zen-browser.app), with the following extensions installed:

- [`custom-new-tab`](https://addons.mozilla.org/en-US/firefox/addon/custom-new-tab-page)
- [`duckduckgo`](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox)
- [`nordpass`](https://addons.mozilla.org/en-US/firefox/addon/nordpass-password-management)
- [`nordvpn`](https://addons.mozilla.org/en-US/firefox/addon/nordvpn-proxy-extension)
- [`privacy-badger`](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17)
- [`raindropio`](https://addons.mozilla.org/en-US/firefox/addon/raindropio)
- [`stylus`](https://addons.mozilla.org/en-US/firefox/addon/styl-us)
- [`ublock`](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
- [`vimium`](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)

My `userChrome.css` and `userContent.css` can be found [here](dotfiles/.config/zen) and are required to be placed in the [`chrome/` subfolder](https://www.userchrome.org) in your Zen profile.

To customise different websites, I am using [Catppuccin User Styles](https://github.com/catppuccin/userstyles) and my personal [configuration](dotfiles/.config/stylus), which should be imported in the extension's preferences.

### Notes - Obsidian

For note-taking, I am using [Obsidian](https://obsidian.md), a very flexible and extensible tool. As sync storage for the Vault (notes, settings, etc.), I am using iCloud.

My current theme is [Catppuccin](https://github.com/catppuccin/obsidian), which can be installed via the built-in plugin manager.

Additionally, I have a few plugins installed:

- [`obsidian-copilot`](https://github.com/logancyang/obsidian-copilot)
- [`obsidian-images-in-editor`](https://github.com/ozntel/oz-image-in-editor-obsidian)
- [`obsidian-tag-wrangler`](https://github.com/pjeby/tag-wrangler)
- [`obsidian-outliner`](https://github.com/vslinko/obsidian-outliner)
- [`obsidian-style-settings`](https://github.com/mgmeyers/obsidian-style-settings)
- [`obsidian-advanced-tables`](https://github.com/tgrosinger/advanced-tables-obsidian)

I also extended the length of readable mode (the default seems quite narrow) by adding custom CSS:

```css
body {
  --file-line-width:1100px
}
```

### Music - Spotify

Spotify is my primary music app, and to customise it I am using [Spicetify](https://github.com/spicetify/cli) and [Spicetify Marketplace](https://github.com/spicetify/marketplace).

My current theme is [Catppuccin](https://github.com/catppuccin/spicetify), which can be installed via Marketplace in the themes tab.

There are no other plugins installed apart from the theme.

### Messengers

#### Messengers - Telegram

My main messenger is [Telegram](https://telegram.org) with my own version of Catppuccin themes. Both themes can be installed using Telegram's theme manager:

- [Catppuccin Latte](https://t.me/addtheme/catppuccin_latte_pivoshenko)
- [Catppuccin Macchiato](https://t.me/addtheme/catppuccin_macchiato_pivoshenko)
- [Catppuccin Mocha](https://t.me/addtheme/catppuccin_mocha_pivoshenko)

#### Messengers - Discord

To stay in touch with different communities, I am using [Discord](https://discord.com), but the official app lacks functionality, so instead I am using [Vesktop](https://github.com/Vencord/Vesktop) with the [Catppuccin](https://github.com/catppuccin/discord) theme installed via "Themes -> Online Themes".

```css
/* frappe, macchiato, mocha */
@dark https://catppuccin.github.io/discord/dist/catppuccin-macchiato-mauve.theme.css
@light https://catppuccin.github.io/discord/dist/catppuccin-latte-mauve.theme.css
```

### Honourable Mentions

[f.lux](https://justgetflux.com) - the best application to control the color of a computer's display, adapting to the time of day: warm at night and like sunlight during the day (supports presets based on geolocation).

[CleanShotX](https://cleanshot.com) - I found the default macOS screenshot tool quite odd; sometimes it blurs the screenshot. But still, for day-to-day screenshots, I am using the default app, but if I need to take a screenshot for some documentation, I am using this tool.

[NordPass](https://nordpass.com) and [NordVPN](https://nordvpn.com) - simply the best password manager and VPN client.

[DBeaver](https://dbeaver.io) - simple but powerful database manager.
 