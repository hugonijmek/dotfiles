local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap

-- map the leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("n", "<Leader>ff", "<cmd> lua require('telescope.builtin').find_files()<CR>", opts)
--map("n", "<Leader>fc", "<cmd> lua require('telescope').extensions.file_browser.actions.create_from_prompt()<CR>", opts)
