vim.pack.add({
    { src = "https://github.com/echasnovski/mini.icons" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

require('mini.icons').setup()
require("oil").setup({
    default_file_explorer = true,
    columns = {"icon"},
    keymaps = {
        ["<C-h>"] = false,
        ["<C-s>"] = false, 
        ["<C-l>"] = false, 
        ["<C-o><C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-o><C-h>"] = { "actions.select", opts = { horizontal = true } },
    },
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "<leader>-","<CMD>Oil<CR>")


