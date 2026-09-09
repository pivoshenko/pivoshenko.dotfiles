default:
    @just --list --unsorted

install: brew dotfiles fish-plugins bat-cache vault-link herdr-integration herdr-plugins

brew:
    brew bundle --force --cleanup --upgrade

dotfiles:
    dotdrop install -c dotdrop.config.yaml -p default --force
    dotdrop install -c dotdrop.config.yaml -p me --force

fish-plugins:
    #!/usr/bin/env fish
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher update

bat-cache:
    bat cache --build

vault-link:
    ln -sfn "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault" ~/Vault

herdr-integration:
    herdr integration install claude

herdr-plugins:
    grep -v '^\s*\(#\|$\)' herdr.plugins | xargs -I {} herdr plugin install {} -y

set-flavor FLAVOR:
    python3 scripts/set_flavor.py {{ FLAVOR }}

spicetify FLAVOR:
    spicetify config current_theme {{ FLAVOR }} color_scheme {{ FLAVOR }}
    spicetify apply
