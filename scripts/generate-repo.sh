#!/bin/bash

set -euo pipefail

ROOT="$(dirname "$0")/.."

RECIPES_DIRECTORY="$ROOT/recipes"
REPO_FILE="$ROOT/repo.yml"
NEW_REPO_FILE="$REPO_FILE.new"

if [ -x "$ROOT/fonz" ]; then
    FONZ="$ROOT/fonz"
else
    FONZ="fonz"
fi

find "$RECIPES_DIRECTORY" -type f -name 'recipe.yml' -print0 | sort -z | xargs -0 cat > "$NEW_REPO_FILE"
$FONZ validate-repo "$NEW_REPO_FILE" >/dev/null
cp -f "$NEW_REPO_FILE" "$REPO_FILE"
rm -f "$NEW_REPO_FILE"
