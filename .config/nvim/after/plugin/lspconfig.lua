require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'lua_ls', 'tsserver', 'eslint', 'yamlls' },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set({ 'n', 'i' }, '<M-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- nvim_lsp object
local nvim_lsp = require 'lspconfig'

-- json
nvim_lsp.jsonls.setup {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
        },
    },
    on_attach = on_attach,
}

-- yaml
nvim_lsp.yamlls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- typescript
nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    single_file_support = false,
}

-- eslint
nvim_lsp.eslint.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- rust
local rt = require 'rust-tools'

local rust_opts = {
    on_attach = on_attach,
    server = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr);

            -- Mappings.
            -- See `:help vim.lsp.*` for documentation on any of the below functions
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, bufopts)
        end,
        standalone = false,
        settings = {
            ['rust-analyzer'] = {
                procMacro = {
                    enable = true
                },
            },
        },
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        dap = {
            adapter = {
                type = "server",
                port = "${port}",
                host = "127.0.0.1",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
                name = "rt_lldb",
            },
        },
    },
};

rt.setup(rust_opts);

-- vim
nvim_lsp.vimls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- lua
nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                }
            },
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

-- Make definition and signature_help bordered
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = 'rounded',
})

-- Set diagnostics signs
local sign = function(o)
    vim.fn.sign_define(o.name, {
        texthl = o.name,
        text = o.text,
        numhl = ''
    })
end

sign({ name = 'DiagnosticSignError', text = '󰅚 ' })
sign({ name = 'DiagnosticSignWarn', text = '󰀪 ' })
sign({ name = 'DiagnosticSignHint', text = '󰌶 ' })
sign({ name = 'DiagnosticSignInfo', text = '󰋽 ' })

vim.diagnostic.config({
    severity_sort = true,
    float = {
        border = 'rounded',
        source = 'always',
    },
})
