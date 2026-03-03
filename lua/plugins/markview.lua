vim.pack.add({
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/nvim-mini/mini.icons" },
})


require("markview").setup({
    preview = {
        enable        = true,
        icon_provider = 'mini',
        modes         = { "c", "n", "no", "i", "v" },
        hybrid_modes  = {"n", "i", "v" },
    },
    markdown_inline = {
        enable = true,
    },
})
