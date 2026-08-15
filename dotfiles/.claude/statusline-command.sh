#!/bin/sh
input=$(cat)

# == Directory ==
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
short_dir=$(basename "$dir")

# == Git branch and status ==
branch=$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null \
  || git -C "$dir" rev-parse --short HEAD 2>/dev/null)
if [ -n "$branch" ]; then
  # +staged ~unstaged ?untracked
  counts=$(git -C "$dir" status --porcelain --ignore-submodules 2>/dev/null | awk '
    /^\?\?/ { untracked++; next }
    { x = substr($0, 1, 1); y = substr($0, 2, 1) }
    x != " " { staged++ }
    y != " " { unstaged++ }
    END {
      if (staged)    printf " +%d", staged
      if (unstaged)  printf " ~%d", unstaged
      if (untracked) printf " ?%d", untracked
    }
  ')
  # up/down against the upstream branch, if any
  tracking=$(git -C "$dir" rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)
  if [ -n "$tracking" ]; then
    behind=$(echo "$tracking" | awk '{print $1}')
    ahead=$(echo "$tracking" | awk '{print $2}')
    [ "$ahead" -gt 0 ] 2>/dev/null && branch="$branch ↑$ahead"
    [ "$behind" -gt 0 ] 2>/dev/null && branch="$branch ↓$behind"
  fi
  branch="${branch}${counts}"
fi

# == Context used ==
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# == Model short name ==
model_display=$(echo "$input" | jq -r '.model.display_name // empty')
model_short=""
if [ -n "$model_display" ]; then
  case "$model_display" in
    *[Oo]pus*)   model_short="opus"   ;;
    *[Ss]onnet*) model_short="sonnet" ;;
    *[Hh]aiku*)  model_short="haiku"  ;;
    *)           model_short=$(echo "$model_display" | awk '{print tolower($NF)}') ;;
  esac
fi

# == Thinking effort level ==
effort=$(echo "$input" | jq -r '.effort.level // empty')

# == Assemble ==
out="$short_dir"
[ -n "$branch" ] && out="$out  $branch"
[ -n "$used" ]   && out="$out  ctx:$(printf '%.0f' "$used")%"
if [ -n "$model_short" ]; then
  if [ -n "$effort" ]; then
    out="$out  $model_short:$effort"
  else
    out="$out  $model_short"
  fi
fi
printf '%s' "$out"
