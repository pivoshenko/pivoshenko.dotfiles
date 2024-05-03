# =============================================================================================
# fzf
# =============================================================================================

_fzf_complete_realpath() {
  local realpath="$1"
  if [ -d "$realpath" ]; then
    tree -a -I '.DS_Store|.localized' -C "$realpath" | head -100
  else
    mime="$(file -Lbs --mime-type "$realpath")"
    category="${mime%%/*}"
    if [ "$category" = 'image' ]; then
      local default_width=$(( "$FZF_PREVIEW_COLUMNS" < 60 ? 60 : "$FZF_PREVIEW_COLUMNS" ))
      catimg -r2 -w "$default_width" "$realpath"
    else
      bat -n \
        --color=always \
        --line-range :100 \
        --theme=catppuccin_mocha \
        "$realpath"
    fi
  fi
}
