# == Themes ==
set -Ux FZF_MOROK "\
--color=bg+:#1c1917,bg:#000000,spinner:#e2cfc6,hl:#c98787 \
--color=fg:#e7e5e4,header:#c98787,info:#a78cc4,pointer:#e2cfc6 \
--color=marker:#9faece,fg+:#e7e5e4,prompt:#a78cc4,hl+:#c98787 \
--color=selected-bg:#292524 \
--color=border:#57534e,label:#e7e5e4"

set -Ux FZF_THEME $FZF_MOROK

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
