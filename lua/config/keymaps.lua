-- -- Keymaps
-- Basics
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>q", ":bd<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>con", function() require('oil').open(vim.fn.stdpath("config")) end)

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>")

-- Docs navigation
vim.keymap.set('n', '<leader>9', '<C-]>', { noremap = true, silent = true })

-- Terminal
if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.keymap.set("n", "<leader>ft", ":split term://pwsh<CR>i")
else
    vim.keymap.set("n", "<leader>ft", ":split | term<CR>i")
end

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]]) -- Escapes terminal insert mode with ESC

-- Spelling correction
vim.keymap.set("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u")
vim.keymap.set("n", "<C-l>", "[s1z=`]")
