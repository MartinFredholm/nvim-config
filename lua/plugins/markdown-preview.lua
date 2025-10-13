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
vim.g.mkdp_math = 'katex'
vim.g.mkdp_preview_options = {
  custom_template_path = vim.fn.expand(vim.fn.stdpath("config") .. "/lua/extras/mkdp-template.html")
}

vim.api.nvim_create_user_command("MarkdownPreviewScroll", function()
    vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0
    }
end, {})

vim.api.nvim_create_user_command("MarkdownPreviewNoScroll", function()
    vim.g.mkdp_preview_options = {
        disable_sync_scroll = 1
    }
end, {})
