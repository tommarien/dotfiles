#!/bin/bash

DAYS=10
CUTOFF=$(date -v-${DAYS}d +%s)

echo "Checking for formulae released more than $DAYS days ago..."

brew outdated --formula --quiet | while read -r pkg; do
  FORMULA_PATH=$(brew info --json=v2 "$pkg" 2>/dev/null | python3 -c "import json,sys; print(json.load(sys.stdin)['formulae'][0]['ruby_source_path'])" 2>/dev/null)

  if [ -z "$FORMULA_PATH" ]; then
    echo "  [WARN] Could not find formula path for $pkg"
    continue
  fi

  RELEASE_TIME=$(curl -sf "https://api.github.com/repos/Homebrew/homebrew-core/commits?path=${FORMULA_PATH}&per_page=1" \
    | python3 -c "import json,sys; from datetime import datetime; d=json.load(sys.stdin); print(int(datetime.strptime(d[0]['commit']['committer']['date'], '%Y-%m-%dT%H:%M:%SZ').timestamp()))" 2>/dev/null)

  if [ -z "$RELEASE_TIME" ]; then
    echo "  [WARN] Could not determine release date for $pkg"
    continue
  fi

  RELEASE_DATE=$(date -r "$RELEASE_TIME" "+%Y-%m-%d")

  if [ "$RELEASE_TIME" -lt "$CUTOFF" ]; then
    echo "  Upgrading $pkg (released: $RELEASE_DATE)"
    brew upgrade "$pkg"
  else
    echo "  Skipping $pkg (released recently: $RELEASE_DATE)"
  fi
done

echo "Done."
