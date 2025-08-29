vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
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
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "python", "html", "yaml", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

    sync_install = false,

    auto_install = true,

    ignore_install = { "javascript", "latex" },

    highlight = {
        enable = true,

        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        additional_vim_regex_highlighting = false,
    },
})
