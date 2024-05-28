return {
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        build = ':Copilot auth',
        event = 'InsertEnter',
        opts = {
            -- setup suggestions for completion
            suggestion = {
                enabled = true,
                accept = false,
                auto_trigger = true,
                prev = '<M-[>',
                next = '<M-]>',
                dismiss = '<M-e>'
            },
            panel = { enabled = true },
            filetypes = {
                ['*'] = true,
            },
        },
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        branch = 'canary',
        dependencies = {
            { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
            { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
        },
        opts = {
            -- debug = true, -- Enable debugging
            -- See Configuration section for rest
        },
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'onsails/lspkind.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    'rafamadriz/friendly-snippets',
                },
                config = function()
                    require('luasnip.loaders.from_vscode').lazy_load()
                end
            },
            'windwp/nvim-autopairs',
        },
        config = function()
            local cmp = require 'cmp'
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local luasnip = require 'luasnip'
            local lspkind = require 'lspkind'
            local copilot_suggestion = require('copilot.suggestion')

            -- Autopairs
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

            -- Copilot
            cmp.event:on('menu_opened', function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on('menu_closed', function()
                vim.b.copilot_suggestion_hidden = false
            end)

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 60,
                        ellipsis_char = '...',
                        menu = {
                            buffer = "[BUF]",
                            cmdline = "[CMD]",
                            luasnip = "[SNIP]",
                            nvim_lsp = "[LSP]",
                            path = "[PATH]",
                        },
                    })
                },
                window = {
                    documentation = vim.tbl_deep_extend('force', {},
                        cmp.config.window.bordered(),
                        {
                            max_height = 15,
                            max_width = 60,
                        }
                    ),
                },
                matching = {
                    disallow_prefix_unmatching = true,
                    disallow_partial_fuzzy_matching = true,
                    disallow_fullfuzzy_matching = true,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local col = vim.fn.col('.') - 1

                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif copilot_suggestion.is_visible() then
                            copilot_suggestion.accept()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' })
                }),
                -- Installed sources
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_lenght = 2, max_item_count = 20 },
                    { name = 'luasnip',  keyword_lenght = 2, },
                    { name = "path", },
                }, {
                    { name = "buffer", keyword_lenght = 4 },
                }),
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, {
                    { name = 'buffer' },
                })
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end
    },
}
