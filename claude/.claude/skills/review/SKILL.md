# Code Review Skill

Review the current branch's changes using Opus as a subagent.

1. Run `git diff main...HEAD` to see all changes
2. Spawn an Opus agent for harsh review focusing on correctness, security, and edge cases
3. Check findings because the agent has no code access
4. Output findings as a numbered list, also the ones you diregarded
5. Wait for user to pick which findings to fix
