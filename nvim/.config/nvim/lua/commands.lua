local create_user_command = vim.api.nvim_create_user_command

-- Light/Dark
create_user_command('ToggleLightDark', function()
    if vim.o.background == 'dark' then
        vim.o.background = 'light'
        vim.cmd [[colorscheme forestbones]]
    else
        vim.o.background = 'dark'
        vim.cmd [[colorscheme gruvbox-material]]
    end
end, { desc = 'Toggle Light/Dark mode' })

-- InlayHints
create_user_command('InlayHintsEnable', function(args)
    local bufnr = nil

    if args.bang then
        bufnr = 0
    end

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end, { desc = "Enable inlay hints", bang = true })

create_user_command('InlayHintsDisable', function(args)
    local bufnr = nil

    if args.bang then
        bufnr = 0
    end

    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
end, { desc = "Disable inlay hints", bang = true })
