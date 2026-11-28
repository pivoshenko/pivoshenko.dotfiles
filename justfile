default:
    @just --list

audit:
    uv audit --preview-features audit-command

build-bat-cache:
    bat cache --build

check: lint audit test

format: format-py format-fish

format-fish:
    git ls-files '*.fish' | xargs fish_indent --write

format-py:
    uv run ruff check --fix .
    uv run ruff format .

install: install-brew-packages install-dotfiles install-fish-plugins build-bat-cache link-vault install-macos-defaults

install-brew-packages:
    brew bundle --force --upgrade
    brew bundle cleanup --force

install-dotfiles:
    dotdrop install -c dotdrop.config.yaml -p default --force
    dotdrop install -c dotdrop.config.yaml -p me --force

install-fish-plugins:
    #!/usr/bin/env fish
    if not functions -q fisher
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
        fisher install jorgebucaran/fisher
    end
    fisher update

install-macos-defaults:
    defaults write org.herf.Flux lateColorTemp -int 1900
    defaults write org.herf.Flux nightColorTemp -int 3400
    defaults write org.herf.Flux wakeTime -int 480
    defaults write org.herf.Flux locationType -string L
    defaults write org.herf.Flux locationTextField -string London
    defaults write org.herf.Flux location -string "51.508530,-0.125740"
    defaults write io.tailscale.ipn.macsys HideDockIcon -bool true
    defaults write io.tailscale.ipn.macsys TailscaleStartOnLogin -bool true

link-vault:
    ln -sfn "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault" ~/Vault

lint: lint-py lint-fish

lint-fish:
    git ls-files '*.fish' | xargs fish_indent --check

lint-py:
    uv run ruff check .
    uv run ty check .

refresh: install update format check

test:
    uv run pytest .

update:
    uv lock --upgrade
    uvx uv-upsync@latest
