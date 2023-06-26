require('nightfox').setup({
    options = {
        styles = {                               -- Style to be applied to different syntax groups
            comments = "italic",                 -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
        },
    },
    groups = {
        duskfox = {
            NormalFloat = { bg = "NONE" },
        }
    }
})


-- setup must be called before loading
vim.cmd('colorscheme duskfox')
