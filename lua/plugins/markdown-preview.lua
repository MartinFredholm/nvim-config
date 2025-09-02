vim.pack.add({
    {
        src = "https://github.com/iamcco/markdown-preview.nvim",
        name = 'markdown-preview',
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    }
})

vim.g.mkdp_browser = 'zen'
vim.g.mkdp_auto_close = 0
vim.g.mkdp_combine_preview = 1
