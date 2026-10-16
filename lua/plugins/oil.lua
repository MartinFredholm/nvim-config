vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
    default_file_explorer = true,
    columns = {"icon"},
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set("n", "<leader>-","<CMD>Oil<CR>")


