-- Basics
require('config.autocmds')
require('config.globals')
require('config.options')
require('config.keymaps')
require('config.colorschemes')

-- LSP
require('config.lsp')

-- Plugins
require('plugins.nvim-cmp')
require('plugins.oil')
require('plugins.vim-tex')
require('plugins.treesitter')
require('plugins.fzf')
require('plugins.startscreen')
require('plugins.luasnip')
require('plugins.render-markdown')
require('plugins.markdown-preview')
require("plugins.zettel").setup({
    notes_dir = vim.fn.expand("~/Documents/Notes/"),
})
require('plugins.nvim-surround')
