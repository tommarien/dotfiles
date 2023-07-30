local telescope = require 'telescope';

telescope.setup({
    defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
    },
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
                i = { ['<c-d>'] = 'delete_buffer' }
            }
        }
    }
});

telescope.load_extension('live_grep_args');
telescope.load_extension('fzf');
