---
name: techlead
description: Tech-lead follow-up digest of the CHAT Jira board — what is stuck, waiting on review/QA/release, or unowned, and who to nudge.
disable-model-invocation: true
---

# Techlead Skill

Board: https://messagemedia.atlassian.net/jira/software/c/projects/CHAT/boards/1573 (project `CHAT`, cloudId `messagemedia.atlassian.net`). Active sprint only, epics excluded. Optional `$ARGUMENTS`: an assignee name to narrow to one person.

Read-only: never transition, comment on, or edit issues unless I ask.

Statuses, in flow order: `Waiting For Refinement` → `PRIORITIZED AND REFINED` → `In Progress` → `READY FOR CODE REVIEW` → `QA IN PROGRESS` → `Ready for release` → Done.

## Steps

1. Dispatch the `scout` agent (search results are huge — keep them out of main context). One JQL per query, `searchJiraIssuesUsingJql`, fields limited to `summary,status,issuetype,priority,assignee,labels,updated,created,parent`, `maxResults` 50. Ask it to return a compact table (key, summary ≤60 chars, assignee, status, days since update) per query:
   - **Stuck in progress**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status = "In Progress" AND updated <= -3d ORDER BY updated ASC`
   - **Waiting on review**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status = "READY FOR CODE REVIEW" ORDER BY updated ASC`
   - **Waiting on QA**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status = "QA IN PROGRESS" ORDER BY updated ASC`
   - **Unreleased**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status = "Ready for release" ORDER BY updated ASC`
   - **Unowned work**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status in ("In Progress","READY FOR CODE REVIEW","QA IN PROGRESS") AND assignee is EMPTY`
   - **Risk**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND statusCategory != Done AND (priority in (High, Highest, Major) OR labels in (Security) OR issuetype = Bug) ORDER BY priority DESC, updated ASC`
   - **Pipeline**: `project = CHAT AND issuetype != Epic AND sprint in openSprints() AND status = "PRIORITIZED AND REFINED" ORDER BY updated ASC` — count per assignee, list unassigned.
   - Narrow all of them with `AND assignee = "<name>"` when `$ARGUMENTS` is given.
2. For anything stuck ≥ 5 days or in review/QA ≥ 2 days, have the scout read the last comments (`getJiraIssue`) to tell *blocked with a reason* from *silent*.
3. Check my own load: `assignee = currentUser() AND issuetype != Epic AND sprint in openSprints() AND statusCategory != Done`.

## Output

Lead with the verdict (healthy / needs attention) in one line, then only non-empty sections:

1. **Nudge today** — per person: the ticket key (link), how long it has sat, and the one question to ask them (blocked on what? review requested from whom? needs a decision?).
2. **Review / QA / release queue** — oldest first; flag who the unblocker is.
3. **Unowned or at risk** — unassigned active work, Security, High/Major, bugs.
4. **Pipeline** — refined tickets per person; flag anyone with an empty queue or a pile of unrefined work (`Waiting For Refinement` count only, no list).
5. **Mine** — my own tickets that need action.

Keep it to what I can act on today. Flag anything the scout could not verify instead of asserting it.
