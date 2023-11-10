-- [[ Keybindings ]]

-- Go to Explorer
vim.keymap.set('n', '<leader>-', vim.cmd.Ex, { desc = 'Go to Explorer' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Navigate left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Navigate down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Navigate left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Navigate right' })
