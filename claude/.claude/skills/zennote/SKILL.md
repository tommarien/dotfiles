---
name: zennote
description: ZenNote Skill
model: haiku
---

# ZenNote Skill

Write general notes/ideas as `.md` files in `/Users/tommar/Library/Mobile Documents/com~apple~CloudDocs/zennotes/inbox/` (separate from the memory vault in its `claude/` subfolder).

1. Just write the note — no `AskUserQuestion`, no plan mode, no clarifying questions unless the target note/folder is genuinely ambiguous.
2. Terse: no line numbers, no code blocks, no padding prose. State the point, not the reasoning around it.
3. Find existing notes with `Bash find`; create with Write, append with Edit. Filename is the note title (e.g. `CHAT-1337 Discovery story.md`).
4. First mention of something that deserves its own note becomes a `[[wikilink]]`.
