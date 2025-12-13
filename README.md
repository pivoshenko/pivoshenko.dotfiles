# pivoshenko's dotfiles

![](https://raw.githubusercontent.com/pivoshenko/dotfiles/main/assets/preview.png)

<p align="center">
  <a href="https://stand-with-ukraine.pp.ua/">
    <img alt="standwithukraine" src="https://img.shields.io/badge/Support-Ukraine-FFC93C?style=flat-square&labelColor=07689F">
  </a>
</p>

- [pivoshenko's dotfiles](#pivoshenkos-dotfiles)
  - [Overview](#overview)
  - [Main principles](#main-principles)
  - [Usage](#usage)
  - [Shell](#shell)
    - [Helix](#helix)
  - [Applications](#applications)
    - [Hotkeys Daemon - Karabiner](#hotkeys-daemon---karabiner)
    - [Tiling Window Manager - Rectangle](#tiling-window-manager---rectangle)
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

- My Brew dependencies, including apps, fonts, LSPs, extensions, etc., see [Brewfile](Brewfile)
- My configs, see [`.config/`](dotfiles/.config)

## Main principles

- Minimalism in all aspects
- Consistency throughout the configuration
- Simplicity in design and configuration
- Unified style [Catppuccin Mocha theme](https://github.com/catppuccin/catppuccin) and [JetBrains Mono font](https://www.jetbrains.com/lp/mono)

## Usage

I am using [DotDrop](https://github.com/deadc0de6/dotdrop) to manage dotfiles.

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

## Shell

For the shell, I am using [Fish](https://fishshell.com), as out of the box it has all batteries included. To manage shell plugins, I am using [Fisher](https://github.com/jorgebucaran/fisher), but there are only a few installed. My complete configuration can be found [here](dotfiles/.config/fish).

In terms of command-line tools, I try to keep them minimal—only the ones I use daily, such as:

- [Bat](https://github.com/sharkdp/bat)
- [Bottom](https://github.com/ClementTsang/bottom)
- [Delta](https://github.com/dandavison/delta)
- [Eza](https://github.com/ogham/exa)
- [Fd](https://github.com/sharkdp/fd)
- [Fzf](https://github.com/junegunn/fzf)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- [K9s](https://github.com/derailed/k9s)
- [LazyGit](https://github.com/jesseduffield/lazygit)
- [LazyDocker](https://github.com/jesseduffield/lazydocker)
- [Yazi](https://github.com/sxyazi/yazi)
- [Zellij](https://github.com/zellij-org/zellij)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)

A complete list of configurations for each tool can be found in the [`.config/`](dotfiles/.config) directory.

### Helix

I use [Helix](https://helix-editor.com) as my main editor for CLI, and I am trying to move all my day-to-day work to it. My configuration can be found [here](dotfiles/.config/helix).
I want to highlight it separately, as it's a truly amazing editor with a lot of features and very handy keybindings out of the box.

## Applications

I am using [Homebrew](https://brew.sh) to install both GUI applications and command-line tools. You can find a list of all applications, as well as LSPs and VSCode plugins, in the [`Brewfile`](Brewfile).

### Hotkeys Daemon - Karabiner

I primarily use an external keyboard, and in most of my apps, I rely on either Vi/Kakoune motions. I find it painful to use the mouse, as it requires moving my right hand off the keyboard and distracts my "zen" state. In most of the dev apps, you can enable such modes, but in the default macOS apps or window manager, such functionality is absent. To resolve this issue, I am using [Karabiner](https://github.com/pqrs-org/Karabiner-Elements).

My configuration can be found [here](dotfiles/.config/karabiner/karabiner.json). The main idea is to implement [home row mode](https://precondition.github.io/home-row-mods) using this [guide](https://havn.blog/2024/03/03/a-good-way.html).

### Tiling Window Manager - Rectangle

I use [Rectangle](https://rectangleapp.com/) as a tiling window manager for macOS, which essentially replicates i3 functionality. My configuration can be found [here](dotfiles/.config/rectangle/config.json).

### Editors

#### Editors - VSCode

I absolutely love [VSCode](https://code.visualstudio.com) - it's a simple and yet very extensible and powerful editor.

Here's a list of [extensions](Brewfile) I use daily, but I try to keep my VSCode setup as simple as possible. It was also heavily influenced by [MakeVSCodeAwesome](https://makevscodeawesome.com).

My VSCode configuration can be found [here](dotfiles/vscode/settings.json).

#### Editors - Zed

Despite my love for VSCode, it still has limitations and I like to explore new tools, so currently I am trying to move my day-to-day work to [Zed](https://zed.dev), which I think, as an editor, has a bright future. I personally like how it can be configured and the way plugins are installed.

My Zed plugins and configuration can be found [here](dotfiles/.config/zed/settings.json).

### Browser - Zen

As a browser, I am using [Zen](https://zen-browser.app), with the following extensions installed:

- [Custom New Tab](https://addons.mozilla.org/en-US/firefox/addon/custom-new-tab-page)
- [DuckDuckGo](https://addons.mozilla.org/en-US/firefox/addon/duckduckgo-for-firefox)
- [NordPass](https://addons.mozilla.org/en-US/firefox/addon/nordpass-password-management)
- [NordVPN](https://addons.mozilla.org/en-US/firefox/addon/nordvpn-proxy-extension)
- [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17)
- [RaindropIo](https://addons.mozilla.org/en-US/firefox/addon/raindropio)
- [Stylus](https://addons.mozilla.org/en-US/firefox/addon/styl-us)
- [uBlock](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)
- [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)

My `userChrome.css` and `userContent.css` can be found [here](dotfiles/.config/zen) and are required to be placed in the [`chrome/` subfolder](https://www.userchrome.org) in your Zen profile.

To customise different websites, I am using [Catppuccin User Styles](https://github.com/catppuccin/userstyles) and my personal [configuration](dotfiles/.config/stylus), which should be imported in the extension's preferences.

### Notes - Obsidian

For note-taking, I am using [Obsidian](https://obsidian.md), a very flexible and extensible tool. As sync storage for the Vault (notes, settings, etc.), I am using iCloud.

My current theme is [Catppuccin](https://github.com/catppuccin/obsidian), which can be installed via the built-in plugin manager.

Additionally, I have a few plugins installed:

- [Obsidian Images in-editor](https://github.com/ozntel/oz-image-in-editor-obsidian)
- [Obsidian Tag Wrangler](https://github.com/pjeby/tag-wrangler)
- [Obsidian Outliner](https://github.com/vslinko/obsidian-outliner)
- [Obsidian Style Settings](https://github.com/mgmeyers/obsidian-style-settings)
- [Obsidian Advanced Tables](https://github.com/tgrosinger/advanced-tables-obsidian)

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

To stay in touch with different communities, I am using [Discord](https://discord.com), but the official app lacks functionality, so instead I am using [Vesktop](https://github.com/Vencord/Vesktop) with the [Catppuccin theme](https://github.com/catppuccin/discord) installed via "Themes -> Online Themes".

```css
/* frappe, macchiato, mocha */
@dark https://catppuccin.github.io/discord/dist/catppuccin-mocha-blue.theme.css
@light https://catppuccin.github.io/discord/dist/catppuccin-latte-blue.theme.css
```

### Honourable Mentions

[f.lux](https://justgetflux.com) - the best application to control the color of a computer's display, adapting to the time of day: warm at night and like sunlight during the day (supports presets based on geolocation).

[NordPass](https://nordpass.com) and [NordVPN](https://nordvpn.com) - simply the best password manager and VPN client.

[DBeaver](https://dbeaver.io) - simple but powerful database manager.
