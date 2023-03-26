-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local jsonFtDetect = vim.api.nvim_create_augroup('jsonFtDetect', { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "tsconfig*.json", ".eslintrc.json" },
  group = jsonFtDetect,
  callback = function(ev)
    vim.api.nvim_buf_call(ev.buf, function()
      vim.api.nvim_cmd({ cmd = 'setf', args = { 'jsonc' } }, {})
    end)
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
  pattern = "Cargo.toml",
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
  end,
})
