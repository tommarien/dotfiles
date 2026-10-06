local function set_js_test_runner()
    vim.ui.input(
        { prompt = 'Enter JS test runner (e.g., jest): ' },
        function(input)
            if input and input ~= '' then
                vim.g['test#javascript#runner'] = input
                vim.notify('Set JS test runner to: ' .. input, vim.log.levels.INFO)
            else
                vim.notify('No runner set.', vim.log.levels.WARN)
            end
        end)
end

return {
    {
        'vim-test/vim-test',
        event = 'VeryLazy',
        enabled = not vim.g.vscode,
        keys = {
            { '<leader>tt', vim.cmd.TestNearest, desc = 'Run Nearest Test' },
            { '<leader>tf', vim.cmd.TestFile,    desc = 'Run Test File' },
            { '<leader>ts', vim.cmd.TestSuite,   desc = 'Run All Test Files' },
            { '<leader>tr', vim.cmd.TestLast,    desc = 'Run Last Test Run' },
            { '<leader>tj', set_js_test_runner,  desc = 'Set JS Test Runner' }
        },
        config = function()
            vim.g['test#strategy'] = 'neovim_sticky'
            vim.g['test#preserve_screen'] = 0
            vim.g['test#neovim_sticky#kill_previous'] = 1
            vim.g['test#neovim_sticky#reopen_window'] = 1
            vim.g['test#neovim_sticky#use_existing'] = 0
        end
    }
}
