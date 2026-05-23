---
name: bearcli
description: Read and write notes in Bear (used as persistent memory / knowledge base). Use when the user mentions Bear, asks to read/write/update a note, or refers to notes as memory.
---

Bear is the user's notes app, used as a personal knowledge base and memory store.

Binary: `/Applications/Bear.app/Contents/MacOS/bearcli` — invoke directly via Bash. Run `bearcli help <subcommand>` for full reference.

## Choose the right write command

In order of preference for editing existing notes:

1. **`edit`** — targeted find/replace or insert. Use this whenever possible. Avoids re-emitting the whole note (the main source of special-character bugs).
2. **`append`** — add to the end or beginning (`--position beginning|end`). Use when adding new content without touching existing content.
3. **`overwrite`** — full replace. Last resort. Use only when restructuring the whole note. Always pair with `--base <hash>` (see below).

For new notes: **`create`** with `--tags` flag (don't rely on inline `#hashtags`).

## Special character handling — the critical rule

Flag arguments (`--content "..."`, `--find "..."`, `--replace "..."`) **interpret escape sequences**: `\n` → newline, `\t` → tab, `\\` → literal backslash, `\r` → CR.

**Stdin does NOT.** What you pipe is what you get, byte-for-byte.

→ For any content containing backslashes, code blocks, regex, paths with `\n`-like patterns, or anything escape-prone, **pipe via stdin**:

```sh
# Safe — content is literal
printf '%s' "$CONTENT" | bearcli overwrite <id> --base <hash>
printf '%s' "$CONTENT" | bearcli append <id>
printf '%s' "$CONTENT" | bearcli create "Title" --tags "work"

# Risky — flag args double-escape
bearcli overwrite <id> --content "line1\nline2"   # \n becomes newline
```

For `edit`, `--find` and `--replace` only take flag args (no stdin), so escape sequences apply. To match a literal backslash, write `\\`. To match a literal newline in content, write `\n`.

## Optimistic concurrency for overwrite

`overwrite` without `--base` will clobber any edits made in the Bear app since you last read the note. Always:

```sh
HASH=$(bearcli show <id> --format json --fields hash | jq -r .hash)
# ... build new content ...
printf '%s' "$CONTENT" | bearcli overwrite <id> --base "$HASH"
```

If the hash check fails, re-read the note, re-apply your changes, retry.

## Reading

- `bearcli cat <id> --format json` → `{"content":"..."}`. Use this to read.
- `bearcli show <id> --format json --fields all` → metadata (id, title, tags, hash, length, modified, etc.). Content excluded unless you add `,content`.
- `bearcli search "<query>" --format json` → list of matching notes. Uses Bear's inline operators (`@title`, `@today`, `#tag`).
- `bearcli search-in <id> "<string>"` → find exact-string occurrences inside one note.
- `bearcli open <id>` opens the UI only — does **not** return content. Never use to read.

## Overwrite content rules (when you must use it)

- First line should be a `# Heading` — Bear derives the title from it.
- Include `#hashtags` to preserve tags. **Omitting tag references drops them.**
- Preserve any existing attachment markdown links. If you don't, the attachment is removed and the write is rejected unless `--force`.

## Tags

- `bearcli tags add <id> --tags "foo,bar/nested"` — safer than editing content to manipulate tags.
- `bearcli tags remove <id> --tags "foo"` — same.
- Nested tags use `/` (e.g. `work/draft`). Multi-word tags allowed.

## Output format & errors

- `--format json` on every read for stable parsing.
- Mutating commands (`edit`, `overwrite`, `append`, `create` partial) are silent on success. Exit code 0 = success, 1 = business error, 64 = usage error.
- With `--format json`, errors come back on stdout as `{"error":{"code":"...","message":"..."}}`.

## Workflow for updating a note (safe path)

1. `bearcli show <id> --format json --fields hash,content` (or `cat` + `show`).
2. Decide: can this be an `edit --find/--replace`? If yes, do that. Done.
3. If not, build new content, pipe via stdin to `overwrite --base <hash>`.
4. On hash mismatch: re-read, re-apply, retry.
