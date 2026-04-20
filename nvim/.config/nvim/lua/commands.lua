local create_user_command = vim.api.nvim_create_user_command

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

create_user_command('ToggleLightDark', function()
    vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
end, { desc = 'Toggle Light/Dark mode' })
