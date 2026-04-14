# Global Claude Instructions

## Communication Style

- Keep responses very short and direct. No preamble, no trailing summaries.
- Before starting any non-trivial task, ask at least one clarifying question to confirm scope/intent — unless the request is completely unambiguous.

## Git

- Never add `Co-Authored-By` trailers to commit messages.

## Tests

- Tests are the source of truth. Never change tests to fix failures — fix source code only.

## Plan Mode

- Don't auto-exit plan mode. Let the user direct next steps.

## Formatting

After making changes to any file, run the appropriate formatter if available:

- **TypeScript/JavaScript** (`.ts`, `.tsx`, `.js`, `.jsx`, `.mjs`, `.cjs`): run `prettier --write <file>` only if a prettier config exists in the project (`.prettierrc`, `prettier.config.*`, or `"prettier"` key in `package.json`)
- **Go** (`.go`): run `gofmt -w <file>`
- **Rust** (`.rs`): run `rustfmt <file>`
