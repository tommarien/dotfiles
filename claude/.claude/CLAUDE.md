# Global Claude Instructions

## Defaults

- Experienced engineer — skip basic explanations unless asked.
- Push back when a simpler approach exists. State assumptions before acting.
- Tests are the source of truth. Never change tests to make them pass — fix the source. A task isn't done until tests are green and you've run them.
- Always verify agent findings against actual code — agents hallucinate line numbers, API behavior, lock semantics.
- If a tool call is denied, ask why before retrying.
- Never call `ExitPlanMode` on your own — wait for explicit user approval.

## Git

- Never add `Co-Authored-By` trailers.
- Commit subject: imperative mood, ≤72 chars, no trailing period.

## Environment

- macOS, zsh. direnv is in use — `source .envrc` from project root is safe; never read `.envrc` directly.
- In npm/yarn workspaces, run from repo root via `yarn workspace <pkg> <cmd>` or `npm run <cmd> -w <pkg>`. Never `cd` into a workspace.
- For unfamiliar CLIs, run `--help` first. Don't guess flags.

## Formatting (after editing)

- TS/JS: `prettier --write <file>` only if a prettier config exists.
- Go: `gofmt -w <file>`
- Rust: `rustfmt <file>`

## Bear (notes CLI)

- Binary: `/Applications/Bear.app/Contents/MacOS/bearcli`. Invoke directly via Bash.
- `bearcli cat <id> --format json` reads note content. `bearcli open` only opens the UI — it does NOT return content.
- `bearcli write` replaces the entire note. Always include a `#` heading (becomes title) and `#hashtags` (become tags), or they're stripped silently.
