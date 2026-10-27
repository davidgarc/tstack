#!/usr/bin/env bash
# Symlink every skill into ~/.agents/skills, then into Claude Code and Codex.
set -euo pipefail

repo="$(cd "$(dirname "$0")" && pwd)"
shared="$HOME/.agents/skills"
targets=("$HOME/.claude/skills" "$HOME/.codex/skills")

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "skip  $dest (exists and is not a symlink)"
    return
  fi
  ln -sfn "$src" "$dest"
  echo "link  $dest -> $src"
}

mkdir -p "$shared" "${targets[@]}"
for dir in "$repo"/skills/*/; do
  name="$(basename "$dir")"
  link "${dir%/}" "$shared/$name"
  for target in "${targets[@]}"; do
    link "$shared/$name" "$target/$name"
  done
done
