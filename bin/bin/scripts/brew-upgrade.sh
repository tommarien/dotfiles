#!/bin/bash

DAYS=15
CUTOFF=$(date -v-${DAYS}d +%s 2>/dev/null || date -d "-${DAYS} days" +%s)

echo "Checking for packages installed/updated more than $DAYS days ago..."

brew outdated --formula | while read -r pkg; do
  # Find the installed keg path
  KEG=$(brew --prefix)/Cellar/$pkg
  if [ ! -d "$KEG" ]; then
    KEG=$(brew --cellar "$pkg" 2>/dev/null)
  fi

  if [ -d "$KEG" ]; then
    # Get modification time of the keg
    MTIME=$(stat -f "%m" "$KEG"/*/. 2>/dev/null | sort -n | tail -1)
    [ -z "$MTIME" ] && MTIME=$(stat -c "%Y" "$KEG" 2>/dev/null)

    if [ -n "$MTIME" ] && [ "$MTIME" -lt "$CUTOFF" ]; then
      INSTALL_DATE=$(date -r "$MTIME" "+%Y-%m-%d" 2>/dev/null || date -d "@$MTIME" "+%Y-%m-%d")
      echo "→ Upgrading $pkg (last updated: $INSTALL_DATE)"
      brew upgrade "$pkg"
    else
      echo "  Skipping $pkg (recently installed/updated)"
    fi
  fi
done

echo "Done."
