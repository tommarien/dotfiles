---
name: autonomous
description: Switch on autonomous mode for this session. Grills the user first, then runs unattended. Use only when the user types /autonomous.
disable-model-invocation: true
---

Follow these rules until the session ends.

## Phase 1: Grill

Interview the user relentlessly until you reach a shared understanding. Map the task as a design tree: every decision branches into the decisions that hang off it.

Work the tree in rounds. The frontier is every decision whose prerequisites are already settled: the questions you can ask now without guessing at answers you haven't heard yet. Ask the whole frontier in one round: number each question and give your recommended answer. Then wait for the user's answers before the next round.

Format a round like so:

❓ **Q1** - **<question title>**: <question body, might be multiple paragraphs, including multiple choices>

➡️ <your recommended answer>

---

❓ **Q2** - **<question title>**: <question body>

➡️ <your recommended answer>

Word each question so "yes" accepts your recommended answer.

Each round the user answers reshapes the tree: settled decisions push the frontier outward and unblock dependent questions. Recompute the frontier and ask the next round. A question whose answer depends on another question still open in this round belongs to a later round.

Finding facts is your job, never the user's. When a frontier question needs a fact from the environment (filesystem, tools, etc.), dispatch a sub-agent to find it; don't ask the user for anything you could look up yourself. Don't block on it: a running exploration is an unsettled prerequisite, so only the questions downstream of it wait for the report; ask the rest of the frontier now. The decisions are the user's: put each to them and wait.

Grilling is done when the frontier is empty: every branch visited, nothing left silently assumed. Don't act until the user confirms shared understanding.

## Phase 2: Plan

Present the plan as an ordered list of idiomatic commits, one per phase. Each entry: conventional-commit subject, one line on what it covers. Each commit is atomic, builds and passes tests on its own, and follows the repo's existing conventions. Ask for approval once.

## Phase 3: Execute

- After approval, run all phases without per-step confirmation.
- Stop only on a blocker or a decision that is the user's to make.
- Work on a task branch; land exactly the planned commits, one per phase.
- Before each commit and before finishing, discover and run the repo's build, lint and tests (CLAUDE.md, package.json scripts, Makefile, go.mod, etc.). Don't finish until they're green.
- Finish with: assumptions made, tests added, anything unverified.
