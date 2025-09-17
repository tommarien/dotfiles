-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Set filetype to jsonc for some files
local jsonFileTypeDetect = vim.api.nvim_create_augroup('jsonFtDetect', { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "tsconfig*.json", ".eslintrc.json" },
    group = jsonFileTypeDetect,
    callback = function(ev)
        vim.api.nvim_buf_call(ev.buf, function()
            vim.api.nvim_cmd({ cmd = 'setf', args = { 'jsonc' } }, {})
        end)
    end,
})

-- Enable spelling for Git commit messages
vim.api.nvim_create_autocmd('BufRead', {
    desc = 'Enable spell check for Git commit messages',
    group = vim.api.nvim_create_augroup('my-git-spelling', { clear = true }),
    pattern = "COMMIT_EDITMSG",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
        vim.api.nvim_feedkeys("ggi", "t", true)
    end,
})
