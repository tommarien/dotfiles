---
name: review
description: Harsh Opus review of the current branch's changes against its base branch.
---

# Code Review Skill

Review the current branch's changes using Opus as a subagent.

1. Resolve the base branch: `git symbolic-ref --short refs/remotes/origin/HEAD` (strip `origin/`); fall back to `main`, then `master`.
2. Spawn an Opus agent (`model: "opus"`) for harsh review focusing on correctness, security, and edge cases. Give it the base branch and tell it to run `git diff <base>...HEAD` itself and read the surrounding code (callers, types, tests) before reporting. Output: file:line + finding + why.
3. Verify each finding against the code — agents hallucinate line numbers and semantics.
4. Output findings as a numbered list, also the ones you disregarded
5. Wait for user to pick which findings to fix
