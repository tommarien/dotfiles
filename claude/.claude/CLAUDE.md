# Global Claude Instructions

## Rules of communication

- Experienced software engineer — skip basic explanations and assume deep technical knowledge.
- Only explain how something works if explicitly asked.
- Keep responses very short and direct. No preamble, no trailing summaries.
- Do not summarize what you changed — the user reviews diffs in their IDE.
- Before starting any non-trivial task, ask at least one clarifying question to confirm scope/intent — unless the request is completely unambiguous.

## Engineering Philosophy

- Prefer simple, readable solutions over clever ones.
- Follow evolutionary architecture: make the smallest change that works now; refactor incrementally as requirements emerge.
- Apply XP practices: small iterations, continuous refactoring, YAGNI, and keep things as simple as possible.

## Agents

- Always verify agent findings against actual code before reporting them as valid — agents can hallucinate facts like lock semantics, line numbers, or API behavior.

## Git

- Never add `Co-Authored-By` trailers to commit messages.

## Tests

- Tests are the source of truth. Never change tests to fix failures — fix source code only.
- A task is not done until the tests pass. Writing code is not enough — run the tests and confirm they're green before reporting completion.

## Tool Denials

- If a tool call is denied, always ask why before proceeding.

## Plan Mode

- Don't auto-exit plan mode. Let the user direct next steps.

## Formatting

After making changes to any file, run the appropriate formatter if available:

- **TypeScript/JavaScript** (`.ts`, `.tsx`, `.js`, `.jsx`, `.mjs`, `.cjs`): run `prettier --write <file>` only if a prettier config exists in the project (`.prettierrc`, `prettier.config.*`, or `"prettier"` key in `package.json`)
- **Go** (`.go`): run `gofmt -w <file>`
- **Rust** (`.rs`): run `rustfmt <file>`
