#!/usr/bin/env python3
"""Activate a theme flavor across every loader in this dotfiles repo.

Usage: python3 scripts/set_flavor.py <morok|popil|vatra>
       just set-flavor <flavor>

All three flavors live under each tool's themes/ directory (vendored by
`just sync-theme` at the `me/` root). This script flips the *active* flavor
reference in every loader: theme-name strings (`palette = "..."`, `theme = "..."`,
`features = "..."`, etc.), source paths (fzf, ghostty), the bottom config
(no native include), the lazygit gui.theme block (no native include), and the
zen path in dotdrop.config.yaml.

After running, deploy with `just dotfiles` to copy configs onto the system.
For tools whose theme is selected by a UI/CLI (vscode, stylus, obsidian,
spicetify), this script can't flip it — switch inside the tool itself.
"""

import pathlib
import re
import shutil
import sys

FLAVORS = ("morok", "popil", "vatra")

if len(sys.argv) != 2 or sys.argv[1] not in FLAVORS:
    sys.exit(f"usage: set_flavor.py <{'|'.join(FLAVORS)}>")

F = sys.argv[1]
ROOT = pathlib.Path(__file__).resolve().parent.parent
DOT = ROOT / "dotfiles"


def edit(rel: str, transform) -> None:
    p = DOT / rel
    before = p.read_text()
    after = transform(before)
    if before == after:
        print(f"  ok     {rel}")
        return
    p.write_text(after)
    print(f"  patch  {rel}")


print(f"set-flavor: flavor={F}")


# == simple regex swaps ==

edit(".config/starship.toml", lambda t: re.sub(r'^palette = "\w+"', f'palette = "{F}"', t, count=1, flags=re.M))
edit(".config/helix/config.toml", lambda t: re.sub(r'^theme = "\w+"', f'theme = "{F}"', t, count=1, flags=re.M))
edit(".config/zellij/config.kdl", lambda t: re.sub(r'^theme "\w+"', f'theme "{F}"', t, count=1, flags=re.M))
edit(".config/k9s/config.yaml", lambda t: re.sub(r"skin: \w+", f"skin: {F}", t, count=1))
edit(".config/bat/config", lambda t: re.sub(r'--theme="\w+"', f'--theme="{F}"', t, count=1))
edit(".config/ghostty/config", lambda t: re.sub(r"^theme = \w+\.conf", f"theme = {F}.conf", t, count=1, flags=re.M))
edit(".gitconfig", lambda t: re.sub(r'(\[delta\]\nfeatures = )"\w+"', rf'\1"{F}"', t, count=1))

edit(
    ".config/zed/settings.json",
    lambda t: re.sub(r'("light":\s*)"\w+"', rf'\1"{F}"', re.sub(r'("dark":\s*)"\w+"', rf'\1"{F}"', t, count=1), count=1),
)

edit(
    ".config/fish/config.fish",
    lambda t: re.sub(r'fish_config theme choose "\w+"', f'fish_config theme choose "{F}"', t, count=1),
)


def patch_fzf(text: str) -> str:
    text = re.sub(r"themes/fzf-\w+\.fish", f"themes/fzf-{F}.fish", text, count=1)
    text = re.sub(r"\$FZF_\w+", f"$FZF_{F.upper()}", text, count=1)
    return text


edit(".config/fish/fzf.fish", patch_fzf)


# == bottom + fastfetch: whole config is the theme; replace from themes/<F>.* ==
for name, ext in (("bottom", "toml"), ("fastfetch", "jsonc")):
    src = DOT / f".config/{name}/themes/{F}.{ext}"
    dst = DOT / f".config/{name}/{'bottom.toml' if name == 'bottom' else 'config.jsonc'}"
    if src.read_text() != dst.read_text():
        shutil.copyfile(src, dst)
        print(f"  patch  {dst.relative_to(DOT)} (← themes/{F}.{ext})")
    else:
        print(f"  ok     {dst.relative_to(DOT)}")


# == lazygit: gui.theme is hand-maintained around. Splice from themes/<F>.yml ==
dist_lg = (DOT / f".config/lazygit/themes/{F}.yml").read_text().splitlines()
theme_body: list[str] = []
in_theme = False
for line in dist_lg:
    if line.startswith("theme:"):
        in_theme = True
        continue
    if in_theme:
        if line and not line.startswith(" "):
            break
        theme_body.append(("  " + line) if line else line)
lg_block = "  theme:\n" + "\n".join(theme_body).rstrip() + "\n"


def patch_lazygit(text: str) -> str:
    return re.sub(
        r"^  theme:\n(?:    .*\n|      .*\n|\n(?=    ))*",
        lg_block,
        text,
        count=1,
        flags=re.M,
    )


edit(".config/lazygit/config.yml", patch_lazygit)


# == dotdrop: zen src paths reference flavor dir name ==
def patch_dotdrop(text: str) -> str:
    return re.sub(r"(src: \.config/zen/)\w+(/userC)", rf"\1{F}\2", text)


# dotdrop.config.yaml lives one level up from dotfiles/, in the repo root.
ddrop = ROOT / "dotdrop.config.yaml"
before = ddrop.read_text()
after = patch_dotdrop(before)
if before != after:
    ddrop.write_text(after)
    print("  patch  dotdrop.config.yaml (zen src)")
else:
    print("  ok     dotdrop.config.yaml")

print("set-flavor: done — run `just dotfiles` to deploy onto the system")
