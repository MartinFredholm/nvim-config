vim.pack.add({
    { src = "https://github.com/ibhagwan/fzf-lua" },
})

vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end)
vim.keymap.set('n', '<leader>fg', function() require('fzf-lua').live_grep() end)
