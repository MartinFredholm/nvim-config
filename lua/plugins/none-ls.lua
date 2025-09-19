vim.pack.add({
    { src = "https://github.com/nvimtools/none-ls.nvim" },
    { src = "https://github.com/nvimtools/none-ls-extras.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },

})


local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        require("none-ls.formatting.ruff").with { extra_args = {
            "--extend-select", "E,I",
            "--ignore", "F401",
            "--line-length","100"
        }
        },
        require("none-ls.formatting.ruff_format"),
    }
})
