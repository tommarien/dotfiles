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
        dependencies = {
            'preservim/vimux'
        },
        keys = {
            { '<leader>tt', vim.cmd.TestNearest,     desc = 'Run Nearest Test' },
            { '<leader>tf', vim.cmd.TestFile,        desc = 'Run Test File' },
            { '<leader>ts', vim.cmd.TestSuite,       desc = 'Run All Test Files' },
            { '<leader>tr', vim.cmd.TestLast,        desc = 'Run Last Test Run' },
            { '<leader>tm', vim.cmd.VimuxZoomRunner, desc = 'Maximize Test Runner' },
            { '<leader>tj', set_js_test_runner,      desc = 'Set JS Test Runner' }
        },
        config = function()
            vim.g['test#strategy'] = 'vimux'
        end
    }
}
