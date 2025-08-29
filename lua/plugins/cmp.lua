-- cmp.lua
vim.pack.add({
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
})
local cmp = require('cmp')
cmp.setup({
    enabled = function()
        -- Enable nvim-cmp only for Markdown files in the Obsidian vault
        local in_obsidian_vault = vim.fn.expand('%:p'):match('^' .. vim.fn.expand('~/Documents/Obsidian/Abyss'))
        return vim.bo.filetype == 'markdown' and in_obsidian_vault
    end,
    sources = {
        { name = 'obsidian',      trigger_characters = { '[[' } },
        { name = 'obsidian_new',  trigger_characters = { '[[' } },
        { name = 'obsidian_tags', trigger_characters = { '#' } },
        { name = 'path' },
        { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),            -- Manual completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection with Enter
        ['<Tab>'] = cmp.mapping.select_next_item(),        -- Navigate with Tab
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),      -- Navigate with Shift-Tab
    }),
})
