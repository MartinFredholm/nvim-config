-- -- Keymaps
-- Basics
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>")
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>con", function() require('oil').open(vim.fn.stdpath("config")) end)

-- Norwegian layout: ø and æ act as [ and ] (øs/æs spelling, ød/æd diagnostics, øb/æb buffers)
vim.keymap.set({ 'n', 'x', 'o' }, 'ø', '[', { remap = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'æ', ']', { remap = true })

-- Terminal
if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.keymap.set("n", "<leader>ft", "<cmd>split term://pwsh<CR>i")
else
    vim.keymap.set("n", "<leader>ft", "<cmd>split | term<CR>i")
end

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]]) -- Escapes terminal insert mode with ESC

-- Spelling correction
vim.keymap.set({ 'n', 'i' }, '<C-l>', function()
    if not vim.wo.spell then return end
    local ns = vim.api.nvim_create_namespace('spellfix')
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local mark = vim.api.nvim_buf_set_extmark(0, ns, row - 1, col, {})

    vim.cmd('normal! [s1z=')

    local pos = vim.api.nvim_buf_get_extmark_by_id(0, ns, mark, {})
    vim.api.nvim_buf_del_extmark(0, ns, mark)
    vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end, { desc = 'Fix last spelling error' })

vim.api.nvim_create_user_command('Msg', function()
    vim.cmd("new | put =execute('messages')")
    vim.bo.buftype = 'nofile'
end, { desc = 'Messages in a scratch buffer' })
