# pivoshenko's dotfiles

![terminal](https://raw.githubusercontent.com/pivoshenko/dotfiles/master/docs/assets/hyperjs.png)

<p align="center">
    <a href="https://github.com/volopivoshenko/dotfiles/blob/main/.pre-commit-config.yaml">
        <img alt="hooks" src="https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit">
    </a>
    <a href="https://www.buymeacoffee.com/volopivoshenko" target="_blank">
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

## 🏗️ 🏠 Tooling and Dotfiles

Set of the tooling and dotfiles.

### 🧑🏻‍💻 Installation

1. Install [`ansible`][ansible]

2. Install [`dotdrop`][dotdrop]

3. Run the following commands to install the necessary tooling and configs:

```shell
ansible-playbook playbook.yaml

dotdrop install -p base

pip install -U -r python/requirements.txt
```

[ansible]: https://pypi.org/project/ansible

[dotdrop]: https://github.com/deadc0de6/dotdrop
