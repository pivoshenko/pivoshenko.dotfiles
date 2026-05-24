default:
    @just --list

brew:
    brew bundle --force --zap --cleanup --upgrade

dotfiles:
    dotdrop install -c dotdrop.config.yaml -p default --force
    dotdrop install -c dotdrop.config.yaml -p macos --force
    dotdrop install -c dotdrop.config.yaml -p me --force

install: brew dotfiles
