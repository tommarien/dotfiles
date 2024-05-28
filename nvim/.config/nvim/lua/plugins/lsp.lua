return {
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        cmd = "Mason",
        opts = {},
    },
    {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        config = function()
            require 'fidget'.setup({
                window = {
                    blend = 0,
                },
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'b0o/schemastore.nvim',
        },
        config = function()
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
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
                vim.keymap.set('n', '<M-.>', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
            end

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
                gopls = {},
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
                    init_options = {
                        hostInfo = 'neovim',
                        -- preferences = {
                        --     includeCompletionsForModuleExports = false
                        -- }
                    },
                    settings = {
                        completions = {
                            completeFunctionCalls = true,
                        }
                    }
                },
                vimls = {},
                yamlls = {},
                rust_analyzer = {
                    cmd = { "rustup", "run", "stable", "rust-analyzer" },
                }
            }

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
        end
    },
}
