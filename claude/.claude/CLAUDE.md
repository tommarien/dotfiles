# Global Claude Instructions

## Planning

- Never call `ExitPlanMode` on your own — wait for explicit user approval.
- When in plan mode, do NOT make edits — only produce the plan and wait for approval.
- Do not invoke skills or tools that mutate state until the plan is explicitly approved.
- Do not suggest invoking other skills (e.g., settings/update-config) when the user only wants a direct CLAUDE.md edit.
- Do not create Jira tickets, branches, or take action until the user explicitly approves the plan. Plan-only means plan-only.

## Communication

- Experienced engineer — skip basic explanations unless asked.
- Push back when a simpler approach exists. State assumptions before acting.
- If multiple interpretations exist, present them — don't pick silently.
- When unclear, stop and ask rather than guessing. (Use judgment on trivial tasks — bias is toward caution over speed.)
- If a tool call is denied, ask why before retrying.

## Engineering

- Tests are the source of truth. Never change tests to make them pass — fix the source. A task isn't done until tests are green and you've run them.
- Fix root causes, not symptoms — e.g. don't paper over type errors with `@ts-ignore`.

## Testing

- Run tests after every meaningful edit; TDD-style when implementing new features.
- Follow TDD discipline: write failing tests first, then implementation. Modify existing test files rather than creating new ones unless explicitly requested.
- Before changing behaviour, ensure a test documents the current behaviour first. Then add tests for the new behaviour (they fail), then implement.

## Code Style Preferences

- Prefer idiomatic built-ins (e.g., Go's `copy()` over append-spread) over clever alternatives.
- Check for existing types before suggesting type extensions or new definitions.

## Simplicity

- Minimum code that solves the problem. No speculative features, abstractions, configurability, or error handling for impossible cases.
- Prefer inlining over single-use abstractions. Extract only on the second use.

## Surgical Changes

- Touch only what the request requires. Every changed line should trace to it.
- Don't refactor, reformat, or "improve" adjacent code. Match existing style even if you'd do it differently.
- Clean up orphans your changes created (now-unused imports/vars/functions). Don't delete pre-existing dead code — mention it instead.

## Delegation

- Default to delegating: research, exploration, multi-file searches, independent checks, and anything that would dump large output into main context all go to subagents.
- Main context's job is to judge and orchestrate, not execute. Read agent reports, verify against actual code (agents hallucinate line numbers, API behavior, lock semantics), then make the edit yourself.
- Fan out independent work in parallel — one message, multiple Agent calls. Don't serialize what doesn't depend.
- Skip delegation only when the path and edit are both known and small. Delegation overhead isn't worth it for a one-line change in a known file.

## Working Style

- Work one step at a time. After each step the user verifies and stages accepted changes before moving on.
- In plan mode, break work into discrete stageable steps in this order: cleanup → spec (baseline) → refactor → spec (new behaviour, expect red) → implement (green).
- When asked to review, improve, or suggest changes to code, EXPLAIN first and wait for approval before editing files. Do not jump straight to Edit tool calls.

## Git

- Follow conventional commit format (feat:, fix:, chore:, etc.).
- Commit subject: imperative mood, ≤72 chars, no trailing period.
- Include a description body, not just the subject line.
- Never add any Co-Authored-By or AI attribution trailers to commits.
- When showing git changes, output actual `git diff` results rather than prose summaries unless explicitly asked for a summary.

## Shell/Environment

- macOS, zsh. direnv is in use — source `.envrc` before env-dependent shell operations; never read `.envrc` directly.
- In npm/yarn workspaces, run from repo root via `yarn workspace <pkg> <cmd>` or `npm run <cmd> -w <pkg>`. Never `cd` into a workspace.
- For unfamiliar CLIs, run `--help` first. Don't guess flags.

## Tooling

- For any file search or grep in the current git-indexed directory, use fff tools.

## Formatting (after editing)

- TS/JS: `prettier --write <file>` only if a prettier config exists.
- Go: `gofmt -w <file>`
- Rust: `rustfmt <file>`

## Bear Notes

- Use the `bearcli` skill to read/write Bear notes (no MCP available).
- When writing to existing notes, preserve the title and tags — append/edit body content only.
