"""Module that contains the script that activates a theme flavor across every loader."""

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

edit(".config/starship.toml", lambda t: re.sub(r'^palette = "\w+"', f'palette = "{F}"', t, count=1, flags=re.MULTILINE))
edit(".config/helix/config.toml", lambda t: re.sub(r'^theme = "\w+"', f'theme = "{F}"', t, count=1, flags=re.MULTILINE))
edit(".config/k9s/config.yaml", lambda t: re.sub(r"skin: \w+", f"skin: {F}", t, count=1))
edit(".config/bat/config", lambda t: re.sub(r'--theme="\w+"', f'--theme="{F}"', t, count=1))
edit(
    ".config/ghostty/config",
    lambda t: re.sub(r"^theme = \w+\.conf", f"theme = {F}.conf", t, count=1, flags=re.MULTILINE),
)
edit(".gitconfig", lambda t: re.sub(r'(\[delta\]\nfeatures = )"\w+"', rf'\1"{F}"', t, count=1))


def patch_zed(text: str) -> str:
    def swap(block: str) -> str:
        block = re.sub(r'("light":\s*)"\w+"', rf'\1"{F}"', block, count=1)
        return re.sub(r'("dark":\s*)"\w+"', rf'\1"{F}"', block, count=1)

    return re.sub(r'"theme":\s*\{[^}]*\}', lambda m: swap(m.group(0)), text, count=1)


edit(".config/zed/settings.json", patch_zed)

edit(
    ".config/fish/config.fish",
    lambda t: re.sub(r'fish_config theme choose "\w+"', f'fish_config theme choose "{F}"', t, count=1),
)


def patch_fzf(text: str) -> str:
    text = re.sub(r"themes/fzf-\w+\.fish", f"themes/fzf-{F}.fish", text, count=1)
    text = re.sub(
        r"^(set -Ux FZF_THEME )\$FZF_\w+", rf"\1$FZF_{F.upper()}", text, count=1, flags=re.MULTILINE
    )
    return text


edit(".config/fish/fzf.fish", patch_fzf)


# == bottom + fastfetch: whole config is the theme; replace from themes/<F>.* ==
for name, ext, filename in (
    ("bottom", "toml", "bottom.toml"),
    ("fastfetch", "jsonc", "config.jsonc"),
):
    src = DOT / f".config/{name}/themes/{F}.{ext}"
    dst = DOT / f".config/{name}/{filename}"
    if src.read_text() != dst.read_text():
        shutil.copyfile(src, dst)
        print(f"  patch  {dst.relative_to(DOT)} (<- themes/{F}.{ext})")
    else:
        print(f"  ok     {dst.relative_to(DOT)}")


# == herdr: the preamble and the [keys] block are hand-maintained, so splice only the theme ==
herdr_theme = (DOT / f".config/herdr/themes/{F}.toml").read_text().rstrip() + "\n"


def patch_herdr(text: str) -> str:
    head = text[: text.index("[theme]")]
    tail = text[text.index("# == Keys ==") :]
    return head + herdr_theme + "\n" + tail


edit(".config/herdr/config.toml", patch_herdr)


# == lazygit: the rest of config.yml is hand-maintained, so splice gui.theme from themes/<F>.yml ==
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
        flags=re.MULTILINE,
    )


edit(".config/lazygit/config.yml", patch_lazygit)


# == dotdrop: zen src paths reference flavor dir name ==
def patch_dotdrop(text: str) -> str:
    return re.sub(r"(src: \.config/zen/)\w+(/userC)", rf"\1{F}\2", text)


ddrop = ROOT / "dotdrop.config.yaml"
before = ddrop.read_text()
after = patch_dotdrop(before)
if before != after:
    ddrop.write_text(after)
    print("  patch  dotdrop.config.yaml (zen src)")
else:
    print("  ok     dotdrop.config.yaml")

print("set-flavor: done, run `just dotfiles` to deploy onto the system")
