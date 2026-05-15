# Global Claude Instructions

## Rules of communication

- Experienced software engineer — skip basic explanations and assume deep technical knowledge.
- Only explain how something works if explicitly asked.
- Keep responses very short and direct. No preamble, no summaries — the user reviews diffs in their IDE.
- Only ask a clarifying question when ambiguity would meaningfully change the approach.

## Engineering Philosophy

- Prefer simple, readable solutions over clever ones.
- Follow evolutionary architecture: make the smallest change that works now; refactor incrementally as requirements emerge.
- Apply XP practices: small iterations, continuous refactoring, YAGNI, and keep things as simple as possible.
- State assumptions explicitly before acting on them. Push back when a simpler approach exists.
- Touch only what you must. Don't improve adjacent code, comments, or formatting. Don't refactor what isn't broken. Match existing style.

## Agents

- Always verify agent findings against actual code before reporting them as valid — agents can hallucinate facts like lock semantics, line numbers, or API behavior.

## Git

- Never add `Co-Authored-By` trailers to commit messages.

## Tests

- Tests are the source of truth. Never change tests to fix failures — fix source code only.
- A task is not done until the tests pass. Writing code is not enough — run the tests and confirm they're green before reporting completion.

## Tool Denials

- If a tool call is denied, always ask why before proceeding.

## Notes

- Bear is used for notes via the CLI at `/Applications/Bear.app/Contents/MacOS/bearcli`. Use Bash to invoke it directly (e.g. `bearcli search`, `bearcli open`, etc.).
- For unfamiliar CLI tools, run `--help` before issuing commands — don't guess flags or option values.
- Use `bearcli cat <id> --format json` to read note content. `bearcli open` just opens Bear UI and returns `{"ok":true}` — it does not return content.
- `bearcli write` replaces the entire note. Bear derives the title from the first `#` heading and tags from inline `#hashtags`. Always include both in the content or they will be silently stripped.

## Environment

- direnv is in use. It is safe to run `source .envrc` from the project root to load environment variables — never read `.envrc` directly.

## Plan Mode

- NEVER call `ExitPlanMode` on your own. Wait for the user to explicitly say to proceed or exit.

## Package Management

- In npm/yarn workspace projects, always run commands from the repo root using the workspace flag (e.g. `yarn workspace <module> <cmd>` or `npm run <cmd> -w <module>`). Never `cd` into a workspace package to run commands.

## Formatting

After making changes to any file, run the appropriate formatter if available:

- **TypeScript/JavaScript** (`.ts`, `.tsx`, `.js`, `.jsx`, `.mjs`, `.cjs`): run `prettier --write <file>` only if a prettier config exists in the project (`.prettierrc`, `prettier.config.*`, or `"prettier"` key in `package.json`)
- **Go** (`.go`): run `gofmt -w <file>`
- **Rust** (`.rs`): run `rustfmt <file>`
