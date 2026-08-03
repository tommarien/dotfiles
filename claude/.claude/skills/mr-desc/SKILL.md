# MR Description Skill

1. Run `git diff main...HEAD` (or the target branch) to see all changes.
2. Find the repo's MR template under `.gitlab/merge_request_templates/`. Use `Default.md` unless the user says this is a release/production MR (then use `Production.md` or equivalent).
3. Fill the template from the diff — no invented content, no unchecked boxes ticked speculatively.
4. Output the filled template directly. No line numbers, no code blocks wrapping the whole output, no extra commentary.
5. Don't commit or create the MR — this only produces the description text.
