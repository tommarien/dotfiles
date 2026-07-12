# Global Claude Instructions

## Planning
- Never call `ExitPlanMode` — wait for user approval.
- Plan-only means plan-only: no edits, no skill invocations, no Jira/branches/side effects until approved.
- Don't suggest other skills when the user asked for a direct edit.

## Communication
- Skip basic explanations.
- Push back when simpler exists. State assumptions before acting.
- Multiple interpretations or unclear request: stop and ask, don't guess (use judgment on trivial tasks).
- If a tool is denied, ask before retrying.
- When asked to review/improve code: explain first, wait for approval, don't jump to Edit.

## Testing & Correctness
- Never edit tests to make them pass — fix the source. Not done until tests are green.
- Fix root causes, not symptoms (no `@ts-ignore` papering).
- TDD: pin current behaviour with a test, add failing tests for new behaviour, then implement. Modify existing test files unless asked otherwise.

## Scope
- Minimum code. No speculative features, abstractions, or error handling for impossible cases.
- Inline single-use abstractions; extract on second use.
- Every changed line must trace to the request. No drive-by refactors/reformats — match existing style.
- Clean up orphans you create; flag (don't delete) pre-existing dead code.
- Prefer idiomatic built-ins over clever alternatives. Reuse existing types before defining new ones.
- Only modify explicitly-named files; no unrequested exploration agents.

## Delegation
- Delegate research, multi-file search, and large-output tasks to subagents; fan out independent calls in parallel.
- Verify agent reports against code (they hallucinate line numbers, APIs, semantics); main context edits.

## Working Style
- One step at a time; user stages between steps.
- Plan order: cleanup → baseline spec → refactor → new spec (red) → implement (green).

## Git
- Conventional commits (feat:, fix:, chore:). Subject: imperative, ≤72 chars, no period. Always include a body.
- No Co-Authored-By / AI attribution trailers.
- Show `git diff` output, not prose summaries, unless asked.

## Shell / Tooling
- macOS/zsh. direnv: source `.envrc`; never read it.
- Workspaces: run from root (`yarn workspace`/`npm -w`); never `cd` in.
- Unknown CLI: `--help` first, don't guess flags.
- Use fff tools for file search/grep.

## Formatting (after editing)
- TS/JS: `prettier --write <file>` if config exists.
- Go: `gofmt -w`. Rust: `rustfmt`.

## ZenNotes Memory
- **Always read `MEMORY.md` at the start of every conversation**, before doing anything else.
- Memory vault: `/Users/tommar/Library/Mobile Documents/com~apple~CloudDocs/zennotes/inbox/claude/`
- Use **fff tools** (`mcp__fff__find_files`, `mcp__fff__grep`, `mcp__fff__multi_grep`) for discovery/search, **Read/Write/Edit** for file access — do NOT use `mcp__zennotes__*` tools (they fail to find files).
- Subfolders: `user`, `feedback`, `project`, `reference`.
- After reading the index, use `mcp__fff__find_files` / `mcp__fff__grep` for deeper search when a topic/project/person is mentioned.
- Save new facts as `.md` files in the appropriate subfolder.
- Each note: frontmatter with `name`, `description`, `metadata.type`; feedback/project notes lead with the rule/fact, then **Why:** and **How to apply:** lines.
