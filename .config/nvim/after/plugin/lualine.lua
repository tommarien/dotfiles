require('lualine').setup({
    options = {
        icons_enabled = true,
        theme = "auto"
    },
    sections = {
        lualine_c = {
            {
                'filename',
                newfile_status = true,
                path = 1,
            },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
    },
})
