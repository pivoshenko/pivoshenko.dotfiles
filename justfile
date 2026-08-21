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

install: brew dotfiles vault-link herdr-integration herdr-plugins

# Activate a theme flavor (morok | popil | vatra) across every loader
set-flavor FLAVOR:
    python3 scripts/set_flavor.py {{ FLAVOR }}

spicetify FLAVOR:
    spicetify config current_theme {{ FLAVOR }} color_scheme {{ FLAVOR }}
    spicetify apply
