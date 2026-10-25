# Global Claude Instructions

## Planning
- `ExitPlanMode` presents the plan for approval — it is not approval. Never start work off the back of it; wait for an explicit go-ahead.
- Plan-only means plan-only: no edits, no skill invocations, no Jira/branches/side effects until approved.
- Don't suggest other skills when the user asked for a direct edit.

## Communication
- Skip basic explanations.
- Push back when simpler exists. State assumptions before acting.
- Multiple interpretations or unclear request: stop and ask, don't guess (use judgment on trivial tasks).
- If a tool is denied, ask before retrying.
- When asked to review/improve code: explain first, wait for approval, don't jump to Edit.
- Be maximally terse: no preamble before acting, no "I'll now..." narration, no unrequested end-of-turn summaries/recaps. Only write a sentence when a decision is needed, a blocker hit, or a direct question was asked.
- Asked to summarize/explain a document: give the gist first, critique only if asked.
- Asked to write a note or doc: just write it — don't use AskUserQuestion/ExitPlanMode to confirm structure first.
- Trust the user's stated version/fact claims about tools and languages; if you disagree, verify (e.g. web search) before pushing back.

## Testing & Correctness
- Never edit tests to make them pass — fix the source. Not done until tests are green.
- Fix root causes, not symptoms (no `@ts-ignore` papering).
- TDD: pin current behaviour with a test, add failing tests for new behaviour, then implement. Modify existing test files unless asked otherwise.
- Mocks: use `vi.mocked`, not `let`-assigned mock variables.
- After a config/script change, state whether it was tested. Test via Bash when possible; otherwise give a one-line verify command.

## Code Comprehension
- Before asserting how code behaves, read the full function body (not just the signature) and cite file:line.
- Flag anything you couldn't verify instead of asserting it.
- For library/SDK behaviour, read the source (node_modules, go mod cache) before answering; label guesses as guesses.
- Tracing references (bot exports, dialogstates, triggers, timers): search exhaustively on the first pass and state link direction (incoming vs outgoing).

## Scope
- Minimum code. No speculative features, abstractions, or error handling for impossible cases.
- Inline single-use abstractions; extract on second use.
- Every changed line must trace to the request. No drive-by refactors/reformats — match existing style.
- Clean up orphans you create; flag (don't delete) pre-existing dead code.
- Prefer idiomatic built-ins over clever alternatives. Reuse existing types before defining new ones.
- Only modify explicitly-named files; no unrequested exploration agents.

## Delegation
- Delegate research, multi-file search, and large-output tasks to subagents; fan out independent calls in parallel.
- Haiku by default for subagents: always pass `model: "haiku"` for read-only, mechanical work — file/grep sweeps, reference tracing, log/test-output triage, summarizing files or diffs, extracting fields, listing/counting, lookups in docs/Jira/Slack. Applies to every agent type, incl. Explore and general-purpose.
- Stronger model only when the subagent must reason, plan, review, or edit. If unsure, start with haiku; escalate only if the report is thin or wrong.
- Haiku subagent prompts: give the exact question, scope (paths/patterns), and output shape (e.g. "file:line + one-line reason, max 20 lines"). No open-ended "investigate".
- Fan-out over many files for bulk mechanical sub-steps also goes to haiku; keep synthesis and decisions in the main context.
- Verify agent reports against code (they hallucinate line numbers, APIs, semantics); main context edits.

## Working Style
- One step at a time; user stages between steps.
- Plan order: cleanup → baseline spec → refactor → new spec (red) → implement (green).

## Git
- Conventional commits (feat:, fix:, chore:). Subject: imperative, ≤72 chars, no period. Body: 1-3 terse bullets max, no essays.
- No Co-Authored-By / AI attribution trailers.
- Show `git diff` output, not prose summaries, unless asked. Doesn't apply to the pre-commit review prompt (see Commit Approval).

## Commit Approval
- Never commit on my own initiative. Before committing, ask me to review the changes (don't show the diff); commit only after I approve.
- Exception: I explicitly asked for the commit (e.g. "commit this", `/commit`).

## Commit & MR Workflow
- Standard flow: review the diff, run build + tests, commit, then generate an MR description and copy it to the clipboard (`pbcopy`).
- Never overwrite the MR template: read it, fill a copy, pipe to `pbcopy`.
- MR/Jira/notes: high-level (problem, goal, key pointers); no implementation steps.

## Shell / Tooling
- macOS/zsh. direnv: source `.envrc`; never read it.
- Workspaces: run from root (`yarn workspace`/`npm -w`); never `cd` in.
- Unknown CLI: `--help` first, don't guess flags.
- Use fff tools for file search/grep.
- Neovim (nvim MCP): `get_targets` lists all instances and agentic.nvim exposes no `$NVIM`/socket env var, so never ask which one. `connect` to each target, run `exec_lua` `return vim.fn.getcwd()`, and use the one matching my cwd (`CLAUDE_CODE_ENTRYPOINT=agentic-nvim` means I'm running inside it). If several match, ask.
- Neovim "open X": `navigate` lands in the current window, which is the Agentic Chat buffer. Instead `exec_lua` to focus a window with `vim.bo[buf].buftype == ''`, then `:edit +<line> <file>`; verify with `nvim_buf_get_name(0)`.

## Formatting (after editing)
- TS/JS: `prettier --write <file>` if config exists.
- Go: `gofmt -w`. Rust: `rustfmt`.

## Notes & Memory
- ZenNotes is a FILE-BASED vault, not an MCP server — read/write with Read, Edit, Write, and Bash. Do not look for zennotes MCP tools.
- **Always read `MEMORY.md` at the start of every conversation**, before doing anything else.
- Memory vault: `/Users/tommar/Library/Mobile Documents/com~apple~CloudDocs/zennotes/inbox/claude/`
- fff can't index the vault — use `Bash find` + `Read` for discovery/search, **Read/Write/Edit** for file access.
- Subfolders: `user`, `feedback`, `project`, `reference`.
- After reading the index, use `Bash find` + `Read` for deeper search when a topic/project/person is mentioned.
- Save new facts as `.md` files in the appropriate subfolder. Memory instructions live in ZenNotes; MEMORY.md is only a pointer — never write memory content into the auto-memory dir itself.
- Each note: frontmatter with `name`, `description`, `metadata.type`; feedback/project notes lead with the rule/fact, then **Why:** and **How to apply:** lines.
