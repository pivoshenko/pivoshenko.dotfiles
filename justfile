default:
    @just --list

brew:
    brew bundle --force --cleanup --upgrade

dotfiles:
    dotdrop install -c dotdrop.config.yaml -p default --force
    dotdrop install -c dotdrop.config.yaml -p me --force

vault-link:
    ln -sfn "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault" ~/Vault

herdr-integration:
    herdr integration install claude

herdr-plugins:
    herdr plugin install thanhdat77/herdr-navigator -y

fish-plugins:
    #!/usr/bin/env fish
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher update

bat-cache:
    bat cache --build

install: brew dotfiles fish-plugins bat-cache vault-link herdr-integration herdr-plugins

set-flavor FLAVOR:
    python3 scripts/set_flavor.py {{ FLAVOR }}

spicetify FLAVOR:
    spicetify config current_theme {{ FLAVOR }} color_scheme {{ FLAVOR }}
    spicetify apply
