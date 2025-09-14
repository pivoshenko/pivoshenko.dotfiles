# == Themes ==
set -Ux FZF_CATPPUCCIN_LATTE " \
--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
--color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
--color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
--color=selected-bg:#BCC0CC \
--color=border:#9CA0B0,label:#4C4F69
"

set -Ux FZF_CATPPUCCIN_FRAPPE " \
--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 \
--color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF \
--color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 \
--color=selected-bg:#51576D \
--color=border:#737994,label:#C6D0F5
"

set -Ux FZF_CATPPUCCIN_MACCHIATO " \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5
"

set -Ux FZF_CATPPUCCIN_MOCHA " \
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4
"

set -Ux FZF_THEME $FZF_CATPPUCCIN_MACCHIATO

# == Commands ==
set -Ux fifc_editor hx

set -Ux FZF_DEFAULT_COMMAND "
fd \
--strip-cwd-prefix \
--type f \
--type l \
--follow
"

set -Ux FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -Ux FZF_ALT_C_COMMAND $FZF_DEFAULT_COMMAND

# == Options ==
set -Ux FZF_DEFAULT_OPTS " \
--height 30% -1 \
--select-1 \
--reverse \
--preview-window='right:wrap' \
--inline-info \
--bind=tab:down,shift-tab:up \
$FZF_THEME
"

set -Ux FZF_CTRL_R_OPTS " \
--preview 'echo {}' \
--preview-window up:3:hidden:wrap \
--bind 'ctrl-/:toggle-preview' \
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
--color header:italic \
$FZF_THEME
"

set -Ux fifc_custom_fzf_opts $FZF_DEFAULT_OPTS
