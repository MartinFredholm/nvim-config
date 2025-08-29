vim.pack.add({
    { src = "https://github.com/obsidian-nvim/obsidian.nvim", tag = "v3.8.0" }, -- Use stable tag
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})
require('plenary')
require('obsidian').setup({
    workspaces = {
        {
            name = "Abyss",
            path = "~/Documents/Obsidian/Abyss"
        },
    },
    completion = {
        nvim_cmp = true,
        blink = false,
        min_chars = 0,
    },
    picker = {
        name = 'fzf-lua',
    },
})
