---
name: mr-desc
description: MR Description Skill
model: haiku
context: fork
disable-model-invocation: true
---

# MR Description Skill

1. Resolve the base branch: the target branch if the user named one, else `git symbolic-ref --short refs/remotes/origin/HEAD` (strip `origin/`), falling back to `main`, then `master`. Run `git diff <base>...HEAD` to see all changes.
2. Find the repo's MR template under `.gitlab/merge_request_templates/`. Use `Default.md` unless the user says this is a release/production MR (then use `Production.md` or equivalent).
3. Fill the template from the diff — no invented content, no unchecked boxes ticked speculatively.
4. Pipe the filled template to `pbcopy`, then output it. No line numbers, no code blocks wrapping the whole output, no extra commentary.
5. Don't commit or create the MR — this only produces the description text.
