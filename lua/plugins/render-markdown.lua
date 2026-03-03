vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-mini/mini.icons',        -- if you use standalone mini plugins
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
require('render-markdown').setup({}) -- only mandatory if you want to set custom options
