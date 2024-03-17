return
    {
        -- [[ Appearance ]]
        -- Colorscheme
        {
            'bluz71/vim-nightfly-colors',
            name = 'nightfly',
            priority = 1000,
            config = function()
                vim.cmd.colorscheme 'nightfly'
            end,
        },

        { 
            'Rigellute/rigel',
            name = 'rigel',
        },


        -- Indent line guides
        { 'lukas-reineke/indent-blankline.nvim',
            main = 'ibl',
            config = function()
                require("ibl").setup()
            end,
        },

        -- Status line
        { 
            'nvim-lualine/lualine.nvim',
            config = function()
                require('lualine').setup {
                    sections = {
                        lualine_x = {'filetype'},
                    },
                }
            end,
        },

        -- [[ Informative ]]
        -- Color highlighter
        {
            'norcalli/nvim-colorizer.lua',
            config = function ()
                require('colorizer').setup()
            end,
        },

        -- Scrollbar
        {
            'petertriho/nvim-scrollbar', 
            config = function()
                local colors = require('nightfly').palette
                require('scrollbar').setup {
                    handle = {
                        color = colors.deep_blue,
                    },
                }
            end,
        },

        -- Gitsigns in sidebar
        {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup()
                require('scrollbar.handlers.gitsigns').setup()
            end,
        },

        -- Todo Highlighting
        {
            'folke/todo-comments.nvim',
            config = function()
                require('todo-comments').setup()
                vim.keymap.set('n', '<leader>ft', vim.cmd.TodoTelescope, { desc = 'Find Todo'})
            end,
        },

        -- Highlighting 
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            lazy = false,
            config = function()
                require('nvim-treesitter.configs').setup {
                    ensure_installed = { 'c', 'python', 'rust', 'go', 'javascript', 'html', 'css', 'lua', 'vim', 'vimdoc', 'query', 'bash' },
                    sync_install = false,
                    auto_install = true,
                    highlight = { enable = true },
                    indent = { enable = true },
                }
            end,
        },

        -- [[ Tools ]]
        -- Display keybind options for a started command
        {
            'folke/which-key.nvim',
            event = 'VeryLazy',
            init = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
            end,
            config = function()
                require('which-key').register {
                    ['<leader>'] = {
                        f = { name = '+find',},
                        d = { name = '+documentation',},
                        c = { name = '+code action',},
                    },
                }
            end,
        },

        -- Fuzzy finder over lists 
        {
            'nvim-telescope/telescope.nvim', tag = '0.1.4',
	    lazy = false,
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function ()
                local builtin = require('telescope.builtin')
                vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
                vim.keymap.set('n', '<leader>fa', function() builtin.find_files( { hidden = true }, { no_ignore = true } ) end, { desc = 'Find all' })
                vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Fing with Grep' })
                vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
                vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Find in Current file' })               
                vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help' })               
            end,
        },

        -- Visual undo tree
        {
            'debugloop/telescope-undo.nvim',
            dependencies = { 'nvim-telescope/telescope.nvim' },
            config = function()
                vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = "undo history" })
                require('telescope').setup()
                require('telescope').load_extension('undo')
            end,

        },

        -- Debugger
        {
            'rcarriga/nvim-dap-ui',
            config = function()
                require("dapui").setup()
            end,

            dependencies = {
                'mfussenegger/nvim-dap',
            },

            config = function()
                local dap = require('dap')
                dap.adapters.gdb = {
                    type = "executable",
                    command = "gdb",
                    args = { "-i", "dap" }
                }
                dap.configurations.c = {
                    {
                        name = "Launch",
                        type = "gdb",
                        request = "launch",
                        program = function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                        cwd = "${workspaceFolder}",
                    },
                }
            end,
        },

        -- [[ Functional ]]
        -- Auto brackets
        {
            'windwp/nvim-autopairs',
            config = function ()
                require('nvim-autopairs').setup()
            end,
        },

        -- Edit brackets
        { 'tpope/vim-surround' },
        -- Automatically adjust indentation settings
        { 'tpope/vim-sleuth' },
        -- Comment stuff out
        { 'tpope/vim-commentary' },
        -- Highlight references
        { 'RRethy/vim-illuminate' },

        -- Autocompletion
        { 
            'hrsh7th/nvim-cmp',
            dependencies = {
                'neovim/nvim-lspconfig',
                'hrsh7th/vim-vsnip',
                'hrsh7th/cmp-vsnip',
                'hrsh7th/cmp-buffer',
                'hrsh7th/cmp-path',
                'hrsh7th/cmp-cmdline',
                'hrsh7th/cmp-nvim-lsp',
                'rafamadriz/friendly-snippets',
            },
            config = function()
                local cmp = require 'cmp'

                local feedkey = function(key, mode)
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
                end

                cmp.setup({
                    snippet = {
                        expand = function(args)
                            vim.fn['vsnip#anonymous'](args.body)
                        end,
                    },

                    mapping = cmp.mapping.preset.insert({
                        ['<C-n>'] = cmp.mapping.select_next_item(),
                        ['<C-p>'] = cmp.mapping.select_prev_item(),
                        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-d>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({select = true,}),
                        ['<Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            elseif vim.fn['vsnip#jumpable'](1) == 1 then 
                                feedkey('<Plug>(vsnip-jump-next)', "")
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                        ['<S-Tab>'] = cmp.mapping(function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            elseif vim.fn['vsnip#jumpable'](-1) == 1 then 
                                feedkey('<Plug>(vsnip-jump-prev)', "")
                            else
                                fallback()
                            end
                        end, { 'i', 's' }),
                    }),

                    sources = cmp.config.sources(
                        {
                            { name = 'nvim_lsp' },
                            { name = 'vsnip' },
                        }, 
                        {
                            { name = 'path' }
                        },
                        {
                            { name = 'buffer' },
                        })
                })

                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ '/', '?' }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = 'buffer' }
                    }
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

                -- lspconfig keybindings
                vim.api.nvim_create_autocmd('LspAttach', {
                    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                    callback = function(ev)
                        -- Enable completion triggered by <c-x><c-o>
                        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                        -- Buffer local mappings.
                        -- See `:help vim.lsp.*` for documentation on any of the below functions
                        -- local opts = { buffer = ev.buf }
                        local nmap = function(keys, func, desc)
                            if desc then
                                desc = 'LSP: ' .. desc
                            end

                            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                        end
                        nmap('<leader>dD', vim.lsp.buf.declaration, 'Go to Declaration')
                        nmap('<leader>dd', vim.lsp.buf.definition, 'Go to Definition')
                        nmap('<leader>dK', vim.lsp.buf.hover, 'Hover Documentation')
                        nmap('<leader>dr', vim.lsp.buf.references, 'Go to References')
                        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
                        nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
                        nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
                        vim.keymap.set('n', '<space>f', function()
                            vim.lsp.buf.format { async = true }
                        end, {buffer = ev.buf, desc = 'Format buffer with LSP'})
                    end,
                })

                -- Set up lspconfig
                local capabilities = require('cmp_nvim_lsp').default_capabilities()
                local enabled_lsps = {'clangd', 'gopls', 'pylsp'}
                for _, lsp in pairs(enabled_lsps) do
                    require('lspconfig')[lsp].setup {
                        capabilities = capabilities
                    }
                end
            end,
        },
    }

