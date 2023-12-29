-- override go ft settings
vim.api.nvim_exec([[
  augroup go_settings
    autocmd!
    autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
  augroup END
]], false)

-- override md ft settings
vim.api.nvim_exec([[
  augroup md_settings
    autocmd!
    autocmd FileType markdown setlocal wrap linebreak
  augroup END
]], false)
