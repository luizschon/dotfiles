vim.g.mapleader = " "

-- File navigation
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window resize util
vim.keymap.set("n", "+", ":res +2<CR>")
vim.keymap.set("n", "-", ":res -2<CR>")

-- Move visual block and auto indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keeps cursor centered while half-page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keeps search terms centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keeps previous register after replacing text
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")
vim.keymap.set("v", "<leader>Y", "\"+Y")

-- Removes button of doom
vim.keymap.set("n", "Q", "<nop>")

-- Turns current file into executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x <CR>", { silent = true })
