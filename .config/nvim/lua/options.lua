-- Set <space> as leader key
vim.g.mapleader = " "

-- line numbers
vim.o.nu = true
vim.o.rnu = true

-- tabs and indentation
vim.o.shiftwidth = 4
vim.o.expandtab = true 
vim.o.autoindent = true 

-- keep file history
vim.o.undofile = true

-- search settings
vim.o.ignorecase = true

-- appearance
vim.o.termguicolors = true

-- screen visual
vim.o.scrolloff = 10

-- buffer settings
vim.o.completeopt = 'noinsert,menuone,noselect'

-- system clipboard
vim.o.clipboard = "unnamedplus"

-- backspace
vim.o.backspace = 'eol', 'start', 'indent'

