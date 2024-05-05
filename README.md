# pivoshenko's dotfiles

![hyperjs](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/hyperjs.png)

<p align="center">
    <a href="https://github.com/pivoshenko/dotfiles/blob/main/.pre-commit-config.yaml">
        <img alt="hooks" src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit">
    </a>
    <a href="https://www.buymeacoffee.com/pivoshenko" target="_blank">
        <img alt="buymeacoffee" src="https://img.shields.io/badge/buy_me_-a_coffee-ff6964?logo=buymeacoffee">
    </a>
    <a href="https://stand-with-ukraine.pp.ua/">
        <img alt="standwithukraine" src="https://img.shields.io/badge/Support-Ukraine-FFD500?style=flat&labelColor=005BBB">
    </a>
    <a href="https://stand-with-ukraine.pp.ua">
        <img alt="standwithukraine" src="https://img.shields.io/badge/made_in-Ukraine-ffd700.svg?labelColor=0057b7">
    </a>
    <a href="https://wakatime.com/badge/user/9862508c-0a86-427a-929c-46186f2d191a/project/24b39197-a8f6-4f01-80d7-3b47449a9d04">
        <img alt="wakatime" src="https://wakatime.com/badge/user/9862508c-0a86-427a-929c-46186f2d191a/project/24b39197-a8f6-4f01-80d7-3b47449a9d04.svg">
    </a>
</p>

- [pivoshenko's dotfiles](#pivoshenkos-dotfiles)
  - [Contents](#contents)
  - [Main principles](#main-principles)
  - [Installation](#installation)
  - [Apps](#apps)
  - [VSCode](#vscode)
  - [CLI](#cli)
    - [fzf](#fzf)
  - [Local configuration](#local-configuration)

## Contents

What's in here?

- All my `brew` dependencies including: applications, fonts, etc. See [`Brewfile`]
- All my global `Python`, `cargo` and `npm` dependencies including: LSP, LSP plugins, etc. See [`requirements`], [`cargo`] and [`npm`]
- All my `macOS` configuration. See [`macos`]
- All my shell configuration. See [`.shell/`] and [`.zshrc`]
- All my `VSCode` configuration and extensions. See [`vscode/`] and [`extensions`]
- All my rest [`.configs/`], [`dotfiles/`] and [`wallpapers/`] :3

## Main principles

- Minimalism in everything
- Consistency
- Simplicity
- One style - [JetBrainsMono] font and [Catppuccin] color palette
- Reduced visual noise, only important things should be shown
- "Please, do not touch my code" - minimal auto-formatting or code flow interruptions
- Security - do not share anything with anyone

## Installation

> [!IMPORTANT]
> I am planning to use [`dotbot`] to set everything instead of `ansible` and `dotdrop` as it doesn't require any external dependencies and can be used as a submodule

I am using [`dotdrop`] to manage dotiles and [`ansible`] to set things up. Steps:

1. Clone this repo with: `git clone https://github.com/pivoshenko/dotfiles dotfiles`
2. `cd dotfiles/`
3. Run the following commands to install the necessary tooling:

```shell
# install core: homebrew, zsh, oh-my-zsh and configs (optional)
ansible-playbook playbooks/shell.yaml

# install dependencies
ansible-playbook playbooks/dependencies.yaml
```
4. Run the following commands to install configs:

```shell
dotdrop -c "dotdrop.yaml" -p base install -f

# macOS only!
dotdrop -c "dotdrop.yaml" -p macos install -f
```

## Apps

I am using [`brew`] to install all free apps for my Mac.
I also sync apps from the App Store with `brew` via [`mas`], so the resulting [`Brewfile`] contains everything.

## VSCode

![vscode](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/vscode.png)

Here's a list of [`extensions`] I use daily, but I try to keep my `VSCode` setup as simple as possible.

I also quite heavily use [`helix`] for in-terminal editing.

## CLI

I am using [`iTerm2`] and [`zellij`] as my main terminal.
As the main shell I am using [`zsh`] with [`oh-my-zsh`] and [`starship`]. To manage shell plugins I am using [`zplug`].
I also have some tools/scripts/aliases to make my working experience better.
But, I try to keep them minimal: only ones I truly use.

I mainly work with:

- `python`

I also have several other languages installed. But I don't use them on a daily basis:

- `rust`
- `ruby`

### fzf

I use [`fzf`] for several tasks:

- `tab` to autocomplete probably all the tools using [`fzf-tab`]

![fzf-tab](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_tab.png)

- `ctrl+r` to fuzzy search command history

![fzf-ctrl+r](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_ctrl_r.png)

- `ctrl+t` to fuzzy search files and dirs in the current tree to include paths in commands with instant previews for text files (content) and directories (inner tree)

![fzf-ctrl+t](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_ctrl_t.png)

- `ctrl+k` to fuzzy search files by name and open/edit them

![fzf-ctrl+k](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_ctrl_k.png)

- `ctrl+f` to fuzzy searc files by content and open/edit them

![fzf-ctrl+f](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_ctrl_f.png)

- `ctrl+g` to work `git` using [`fzf-git`]

![fzf-ctrl+g](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_ctrl_g.png)

- `space+tab` after `z <path>` to enable fuzzy finder for [`zoxide`]

![fzf-space+tab](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/fzf_space_tab.png)

## Local configuration

Some of the used tools require local configuration, such as `git` with username and email.

Here's the full list:

- `~/.gitconfig.local` to store any user-specific data
- `~/.shell/.local` to store local shell config, like usernames, passwords, tokens, `gpg` keys etc

[`Brewfile`]: https://github.com/pivoshenko/dotfiles/blob/main/dependencies/Brewfile
[`requirements`]: https://github.com/pivoshenko/dotfiles/blob/main/dependencies/requirements.txt
[`cargo`]: https://github.com/pivoshenko/dotfiles/blob/main/playbooks/dependencies.yaml#L17-L22
[`npm`]: https://github.com/pivoshenko/dotfiles/blob/main/playbooks/dependencies.yaml#L30-L51
[`macos`]: https://github.com/pivoshenko/dotfiles/blob/main/macos/settings.sh
[`.shell/`]: https://github.com/pivoshenko/dotfiles/tree/main/dotfiles/.shell
[`.zshrc`]: https://github.com/pivoshenko/dotfiles/tree/main/dotfiles/.zshrc
[`vscode/`]: https://github.com/pivoshenko/dotfiles/tree/main/dotfiles/vscode
[`extensions`]: https://github.com/pivoshenko/dotfiles/blob/main/dependencies/Brewfile#L229-L292
[`.configs/`]: https://github.com/pivoshenko/dotfiles/tree/main/dotfiles/.config
[`dotfiles/`]: https://github.com/pivoshenko/dotfiles/tree/main/dotfiles
[JetBrainsMono]: https://www.jetbrains.com/lp/mono/
[Catppuccin]: https://github.com/catppuccin/catppuccin
[`dotdrop`]: https://github.com/deadc0de6/dotdrop
[`ansible`]: https://github.com/ansible/ansible
[`dotbot`]: https://github.com/anishathalye/dotbot
[`zsh`]: https://github.com/zsh-users/zsh
[`oh-my-zsh`]: https://github.com/robbyrussell/oh-my-zsh
[`starship`]: https://starship.rs
[`zplug`]: https://github.com/zplug/zplug
[`brew`]: https://brew.sh/
[`mas`]: https://formulae.brew.sh/formula/mas
[`helix`]: https://helix-editor.com
[`wallpapers/`]: https://github.com/pivoshenko/dotfiles/blob/main/wallpapers
[`zellij`]: https://zellij.dev
[`fzf`]: https://github.com/junegunn/fzf
[`fzf-tab`]: https://github.com/Aloxaf/fzf-tab
[`fzf-git`]: https://github.com/junegunn/fzf-git.sh
[`zoxide`]: https://github.com/ajeetdsouza/zoxide
[`iTerm2`]: https://iterm2.com/
