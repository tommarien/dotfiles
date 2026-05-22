# Global Claude Instructions

## Defaults

- Experienced engineer — skip basic explanations unless asked.
- Push back when a simpler approach exists. State assumptions before acting.
- Tests are the source of truth. Never change tests to make them pass — fix the source. A task isn't done until tests are green and you've run them.
- Always verify agent findings against actual code — agents hallucinate line numbers, API behavior, lock semantics.
- If a tool call is denied, ask why before retrying.
- For any file search or grep in the current git-indexed directory, use fff tools.

## Working Style

- Work one step at a time. After each step the user verifies and stages accepted changes before moving on.
- In plan mode, break work into discrete stageable steps in this order: cleanup → spec (baseline) → refactor → spec (new behaviour, expect red) → implement (green).
- TDD: before changing behaviour, ensure a test documents the current behaviour first. Then add tests for the new behaviour (they fail), then implement.

## Commits

- Follow conventional commit format (feat:, fix:, chore:, etc.)
- Do not commit until user explicitly requests it

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

## Planning Mode

- Never call `ExitPlanMode` on your own — wait for explicit user approval.
- When in plan mode, do NOT make edits — only produce the plan
- Do not suggest invoking other skills (e.g., settings/update-config) when the user only wants a direct CLAUDE.md edit

## Bear (notes CLI)

- Binary: `/Applications/Bear.app/Contents/MacOS/bearcli`. Invoke directly via Bash.
- `bearcli cat <id> --format json` reads note content. `bearcli open` only opens the UI — it does NOT return content.
- `bearcli write` replaces the entire note. Always include a `#` heading (becomes title) and `#hashtags` (become tags), or they're stripped silently.

## Typescript

- Fix root type issues rather than adding @ts-ignore
- Check if types already exist before suggesting extensions
