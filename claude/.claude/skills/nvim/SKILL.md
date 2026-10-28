---
name: nvim
description: Pick and drive the right Neovim instance via the nvim MCP. Use before any nvim MCP call, or when asked to open a file in Neovim.
---

# Neovim Skill

- `get_targets` lists all instances and agentic.nvim exposes no `$NVIM`/socket env var, so never ask which one. `connect` to each target, run `exec_lua` `return vim.fn.getcwd()`, and use the one matching my cwd (`CLAUDE_CODE_ENTRYPOINT=agentic-nvim` means I'm running inside it). If several match, don't ask: pick the one whose `AgenticChat` buffer (`filetype == 'AgenticChat'`) ends with my pending tool call, which is the instance hosting this session.
- "Open X": `navigate` lands in the current window, which is the Agentic Chat buffer. Instead `exec_lua` to focus a window with `vim.bo[buf].buftype == ''`, then `:edit +<line> <file>`; verify with `nvim_buf_get_name(0)`.
