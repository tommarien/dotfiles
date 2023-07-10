local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls");

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.rustfmt,
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(c)
                            return c.name == "null-ls"
                        end
                    })
                end,
            })
        end
    end,
})

-- Create command to disable lsp autoformat on write
vim.api.nvim_create_user_command(
    'DisableLspFormatting',
    function()
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
    end,
    { nargs = 0 }
)
