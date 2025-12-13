return {
    {
        'github/copilot.vim',
        lazy = false,
        enabled = not vim.g.vscode,
        config = function()
            vim.g.copilot_enabled = true
            vim.g.copilot_no_tab_map = true

            vim.keymap.set('i', '<M-j>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false
            })

            vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)')

            vim.g.copilot_filetypes = {
                gitcommit = true
            }
        end
    },
    {
        'olimorris/codecompanion.nvim',
        enabled = not vim.g.vscode,
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        cmd = {
            'CodeCompanion',
            'CodeCompanionActions',
            'CodeCompanionChat',
            'CodeCompanionCmd',
        },
        opts = {
            strategies = {
                chat = {
                    adapter = 'copilot'
                },
                inline = {
                    adapter = 'copilot',
                },
                agent = {
                    adapter = 'copilot',
                },
            }
        }
    },
    {
        'saghen/blink.cmp',
        dependencies = {
            'rafamadriz/friendly-snippets',
            'xzbdmw/colorful-menu.nvim',
        },

        enabled = not vim.g.vscode,

        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                preset = 'enter',

                ['<C-y>'] = { 'select_and_accept', 'fallback' },
                ['<Tab>'] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_next()
                        end
                    end,
                    'snippet_forward',
                    'fallback'
                },
                ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            cmdline = {
                keymap = { preset = 'inherit' },
                completion = {
                    list = { selection = { preselect = false, auto_insert = true } },
                    menu = { auto_show = true },
                },
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = {
                documentation = { auto_show = false },
                menu = {
                    draw = {
                        -- We don't need label_description now because label and label_description are already
                        -- combined together in label by colorful-menu.nvim.
                        columns = { { 'kind_icon' }, { 'label', gap = 1 } },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require('colorful-menu').blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require('colorful-menu').blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = 'lua'` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = 'prefer_rust'`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = 'prefer_rust_with_warning' }
        },
        opts_extend = { 'sources.default' }
    }
}
