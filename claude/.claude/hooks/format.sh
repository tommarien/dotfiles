#!/usr/bin/env bash
# PostToolUse on Edit|Write: format the touched file.
f=$(jq -r '.tool_input.file_path // empty')
[ -f "$f" ] || exit 0

case "$f" in
    *.go) gofmt -w "$f" ;;
    *.rs) rustfmt "$f" ;;
    *.ts | *.tsx | *.js | *.jsx | *.mjs | *.cjs | *.mts | *.cts)
        # Only when the repo root has a prettier config; use the repo's own prettier.
        root=$(git -C "$(dirname "$f")" rev-parse --show-toplevel 2>/dev/null) || exit 0
        compgen -G "$root/.prettierrc*" >/dev/null || compgen -G "$root/prettier.config.*" >/dev/null || exit 0
        [ -x "$root/node_modules/.bin/prettier" ] && "$root/node_modules/.bin/prettier" --write "$f"
        ;;
esac
exit 0
