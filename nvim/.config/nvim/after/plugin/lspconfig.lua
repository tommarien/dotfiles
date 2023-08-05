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
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set({ 'n', 'v' }, '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = {
    eslint = {},
    jsonls = {
        settings = {
            json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
            },
        },
    },
    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
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
    },
    tsserver = {
        single_file_support = false,
    },
    vimls = {},
    yamlls = {},
}

require('mason').setup()
require('mason-lspconfig').setup({
    -- ensure_installed = { 'lua_ls', 'tsserver', 'eslint', 'yamlls' },
    -- install all necessary language servers
    ensure_installed = vim.tbl_keys(servers),
})

-- nvim_lsp object
local nvim_lsp = require 'lspconfig'

for server_name, server_settings in pairs(servers) do
    nvim_lsp[server_name].setup(vim.tbl_extend('force', {
        capabilities = capabilities,
        on_attach = on_attach,
    }, server_settings))
end

-- rust needs special handling
local rt = require 'rust-tools'

local rust_opts = {
    capabilities = capabilities,
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

-- efm
local prettier = {
    formatCanRange = true,
    formatCommand =
    [[prettierd --stdin-filepath ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} ${--tab-width:tab_width} ${--use-tabs=!insertSpaces}]],
    formatStdin = true,
    rootMarkers = {
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.js",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.mjs",
        ".prettierrc.cjs",
        ".prettierrc.toml",
    },
}

local prettier_formatted_languages = {
    "css",
    "html",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "markdown",
    "scss",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "yaml",
}

local efm_languages = {}

for _, lang in pairs(prettier_formatted_languages) do
    efm_languages[lang] = { prettier }
end

nvim_lsp.efm.setup {
    filetypes = prettier_formatted_languages,
    on_attach = on_attach,
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
    settings = {
        languages = efm_languages
    },
}

-- Switch for controlling whether you want autoformatting.
--  Use :FormatToggle to toggle autoformatting on or off
local format_is_enabled = true
vim.api.nvim_create_user_command('FormatToggle', function()
    format_is_enabled = not format_is_enabled
    print('Setting autoformatting to: ' .. tostring(format_is_enabled))
end, {})

-- Create an augroup that is used for managing our formatting autocmds.
--      We need one augroup per client to make sure that multiple clients
--      can attach to the same buffer without interfering with each other.
local _augroups = {}
local get_augroup = function(client)
    if not _augroups[client.id] then
        local group_name = 'my-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
    end

    return _augroups[client.id]
end

-- Whenever an LSP attaches to a buffer, we will run this function.
--
-- See `:help LspAttach` for more information about this autocmd event.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my-lsp-attach-format', { clear = true }),
    -- This is where we attach the autoformatting for reasonable clients
    callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
            return
        end

        if client.name == 'tsserver' then
            return
        end

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
                if not format_is_enabled then
                    return
                end

                vim.lsp.buf.format {
                    async = false,
                    filter = function(c)
                        return c.id == client.id
                    end,
                }
            end,
        })
    end,
})

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
