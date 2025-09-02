vim.pack.add({
    { src = "https://github.com/OXY2DEV/markview.nvim" },
})

require("markview").setup({
    preview = {
        enable        = true,
        icon_provider = 'mini',
        modes         = { "c", "n", "no", "i", "v" },
        hybrid_modes  = { "i", "v" },
    },

    markdown_inline = {
        enable = true,
    },
})
