return {
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate',
        cmd = 'Mason',
        opts = {},
    },
    {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'b0o/schemastore.nvim',
            'yioneko/nvim-vtsls',
            -- 'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

            local vstlsLanguageSettings = {
                updateImportsOnFileMove = { enabled = 'always' },
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = { enabled = 'literals' },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
            }

            -- Enable the following language servers
            local servers = {
                buf_ls = {},
                eslint = {},
                jsonls = {
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        }
                    }
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            hint = {
                                enable = true,
                            },
                            workspace = { checkThirdParty = false },
                            format = {
                                enable = true,
                                -- Put format options here
                                -- NOTE: the value should be STRING!!
                                defaultConfig = {
                                    indent_style = 'space',
                                    indent_size = '4',
                                }
                            },
                            diagnostics = {
                                globals = { 'vim' }
                            }
                        }
                    }
                },
                vimls = {},
                vtsls = {
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = vstlsLanguageSettings,
                        javascript = vstlsLanguageSettings,
                    },
                },
                yamlls = {},
                rust_analyzer = {
                    cmd = { 'rustup', 'run', 'stable', 'rust-analyzer' },
                }
            }

            require('mason-lspconfig').setup({
                -- install all necessary language servers
                ensure_installed = vim.tbl_keys(servers),
            })

            -- global config
            vim.lsp.config('*', {
                capabilities = capabilities,
            })

            -- config specific settings and enable
            for server_name, server_settings in pairs(servers) do
                vim.lsp.config(server_name, server_settings)
                vim.lsp.enable(server_name)
            end

            -- remove vim.lsp.config defaults
            vim.keymap.del('n', 'gra')
            vim.keymap.del('n', 'gri')
            vim.keymap.del('n', 'grn')
            vim.keymap.del('n', 'grr')

            -- add custom
            local keyBindOpts = { noremap = true, silent = true }

            local function with_desc(desc)
                return vim.tbl_extend('force', keyBindOpts, { desc = desc })
            end

            vim.keymap.set('n', 'gl', vim.diagnostic.open_float, with_desc('Show inline diagnostics'))
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, with_desc('Go to declaration'))
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, with_desc('Go to definition'))
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, with_desc('Show hover'))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, with_desc('Go to implementation'))
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, with_desc('Go to type definition'))
            vim.keymap.set({ 'n', 'i' }, '<c-s>', vim.lsp.buf.signature_help, with_desc('Show signature help'))
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, with_desc('Add workspace folder'))
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, with_desc('Remove workspace folder'))
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, with_desc('List workspace folders'))
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, with_desc('Rename symbol'))
            vim.keymap.set('n', 'g.', vim.lsp.buf.code_action, with_desc('Code action'))
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, with_desc('Show references'))
        end
    },
    {
        'olexsmir/gopher.nvim',
        ft = 'go',
        -- branch = 'develop', -- if you want develop branch
        -- keep in mind, it might break everything
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        -- (optional) will update plugin's deps on every update
        ---@type gopher.Config
        opts = {},
    }
}
