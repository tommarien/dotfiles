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
            'simrat39/rust-tools.nvim',
            'b0o/schemastore.nvim',
            'mattn/efm-langserver'
        },
        config = function()
            -- Switch for controlling whether you want autoformatting.
            --  Use :FormatOnSaveToggle to toggle autoformatting on or off
            local format_on_save_enabled = true

            vim.api.nvim_create_user_command('FormatOnSaveToggle', function()
                format_on_save_enabled = not format_on_save_enabled
                if format_on_save_enabled then
                    vim.notify("Enabled format on save", vim.log.levels.INFO)
                else
                    vim.notify("Disabled format on save", vim.log.levels.INFO)
                end
            end, {})

            -- Gets all lsp clients that support formatting
            -- and have not disabled it in their client config
            -- @param client lsp.Client
            local supports_format = function(client)
                if
                    client.config
                    and client.config.capabilities
                    and client.config.capabilities.documentFormattingProvider == false
                then
                    return false
                end
                return client.supports_method("textDocument/formatting") or
                    client.supports_method("textDocument/rangeFormatting")
            end

            -- Format current buffer
            -- @param opts? { bufnr?:number, async?:boolean, silent?:boolean }
            local format = function(opts)
                opts = opts or {}
                local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()

                local active_clients = vim.lsp.get_active_clients({ bufnr })
                local formatting_clients = vim.tbl_filter(supports_format, active_clients)

                local efm = nil

                for _, cl in ipairs(formatting_clients) do
                    if cl.name == "efm" then
                        efm = cl
                        break
                    end
                end

                local silent = opts.silent or false

                if vim.tbl_isempty(formatting_clients) then
                    if not silent then
                        vim.notify("No lsp clients attached that support formatting", vim.log.levels.WARN)
                    end
                    return
                end

                local async = opts.async or true

                vim.lsp.buf.format({
                    async,
                    filter = function(client)
                        if not efm then
                            return true
                        else
                            return client.id == efm.id
                        end
                    end,
                })
            end

            vim.api.nvim_create_user_command('Format', function()
                format()
            end, { desc = "Format current buffer with LSP" })

            vim.api.nvim_create_autocmd("BufWritePre", {
                group = vim.api.nvim_create_augroup("FormatOnSave", {}),
                callback = function()
                    if format_on_save_enabled then
                        format({ async = false, silent = true })
                    end
                end,
            })

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
                vim.keymap.set({ 'n', 'v' }, '<leader>F', function() format({ async = true, bufnr }) end, bufopts)
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
                    }
                },
                vimls = {},
                yamlls = {},
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
                "jsonc",
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
        end
    },
}
