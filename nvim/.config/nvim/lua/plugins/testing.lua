return {
    {
        'vim-test/vim-test',
        event = 'VeryLazy',
        dependencies = {
            'preservim/vimux'
        },
        keys = {
            { "<leader>tt", vim.cmd.TestNearest,     desc = 'Run Nearest Test' },
            { "<leader>tf", vim.cmd.TestFile,        desc = 'Run Test File' },
            { "<leader>ts", vim.cmd.TestSuite,       desc = 'Run All Test Files' },
            { "<leader>tr", vim.cmd.TestLast,        desc = 'Run Last Test Run' },
            { "<leader>tm", vim.cmd.VimuxZoomRunner, desc = 'Maximize Test Runner' }

        },
        config = function()
            vim.g['test#strategy'] = 'vimux'
        end
    }
}
