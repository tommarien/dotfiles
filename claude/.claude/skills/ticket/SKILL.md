---
name: ticket
description: Start work on a Jira ticket — load ticket + memory context, grill, then plan isolated, tested commits.
disable-model-invocation: true
---

# Ticket Skill

Ticket: `$ARGUMENTS`. The branch/worktree already exists — don't create or switch branches.

1. **Load the ticket** via the Atlassian MCP (`getJiraIssue`): summary, description, acceptance criteria, linked issues.
2. **Load memory**: `Bash find` the vault's `project/` for notes matching the key, read them and their `[[wikilinks]]`. If none exists, create `project/<KEY>.md` (memory note format from global CLAUDE.md): problem, goal, links — no implementation steps.
3. **Grill** (challenge-me style): one question at a time, each with your recommended answer, walking the design tree until shared understanding. Facts are yours to find — dispatch the `scout` agent instead of asking me.
4. **Plan** per the `plan` skill rules: plan-only, no edits until approved. Ordered list of commits, each:
   - isolated to one concern — split refactors, renames, and behaviour changes into separate commits;
   - tested on its own (builds, existing tests green, new behaviour covered);
   - conventional-commit subject + one line on what it covers.
5. On approval, append the plan to the ticket's project note.
