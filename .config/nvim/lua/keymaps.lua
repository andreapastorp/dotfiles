-- [[ Keybindings ]]
-- Set <space> as leader key
vim.g.mapleader = " "

-- Go to Explorer
vim.keymap.set("n", "<leader>-", vim.cmd.Ex)

-- Telescope
vim.keymap.set('n', '<leader>ff', '<cmd> Telescope find_files<CR>', { desc = "Find files" } )
vim.keymap.set('n', '<leader>fg', '<cmd> Telescope live_grep<CR>', { desc = "Live grep" } )
vim.keymap.set('n', '<leader>fb', '<cmd> Telescope buffers<CR>', { desc = "Find buffers" } )
vim.keymap.set('n', '<leader>fa', '<cmd> Telescope find_files follow=true no_ignore=true hidden=true<CR>', { desc = "Find all" } )
vim.keymap.set('n', '<leader>fz', '<cmd> Telescope current_buffer_fuzzy_find<CR>', { desc = "Find in Buffer" } )
vim.keymap.set('n', '<leader>fh', '<cmd> Telescope help_tags<CR>', { desc = "Help Page" } )
