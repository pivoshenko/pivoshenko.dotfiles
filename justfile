default:
    @just --list

install:
    brew bundle --force --zap --cleanup --upgrade
    dotdrop install -c dotdrop.config.yaml -p default --force
    dotdrop install -c dotdrop.config.yaml -p macos --force
