default:
    @just --list

install: install-brew-packages install-dotfiles install-fish-plugins build-bat-cache link-vault install-herdr-integration install-herdr-plugins

build-bat-cache:
    bat cache --build

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

install-herdr-integration:
    herdr integration install claude

install-herdr-plugins:
    grep -v '^\s*\(#\|$\)' herdr.plugins | xargs -I {} herdr plugin install {} -y

format: format-py format-fish

format-py:
    uv run ruff check --fix .
    uv run ruff format .

format-fish:
    git ls-files '*.fish' | xargs fish_indent --write

lint: lint-py lint-fish

lint-py:
    uv run ruff check .
    uv run ty check .

lint-fish:
    git ls-files '*.fish' | xargs fish_indent --check

test:
    @[ -f .no-tests ] && echo "skipping (.no-tests sentinel)" || { echo "no test command, add tests or restore .no-tests" >&2; exit 1; }

check: lint test

update:
    uv lock --upgrade
    uvx uv-upsync

link-vault:
    ln -sfn "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault" ~/Vault

set-flavor FLAVOR:
    python3 scripts/set_flavor.py {{ FLAVOR }}

set-spicetify-flavor FLAVOR:
    spicetify config current_theme {{ FLAVOR }} color_scheme {{ FLAVOR }}
    spicetify apply
