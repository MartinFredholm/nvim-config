-- -- Keymaps
-- Basics
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>con", function() require('oil').open(vim.fn.stdpath("config")) end)
-- Saving File
vim.keymap.set("n", "<C-s>", ":update<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:update<CR>a")
vim.keymap.set("v", "<C-s>", "<Esc>:update<CR>")

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")

-- Splitting and Rezising windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", ":split<CR>")
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Terminal
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.keymap.set("n", "<leader>ft", ":split term://pwsh<CR>i")
else
    vim.keymap.set("n", "<leader>ft", ":split | term<CR>i")
end

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- Window navigation
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")

-- Spelling correction
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set("n", "<C-l>", "[s1z=`]")
