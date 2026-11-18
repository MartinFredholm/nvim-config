vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
})

require('mini.icons').setup()

require('mini.pairs').setup({
    modes = { insert = true, command = false, terminal = false },
    mappings = {
        -- Don't pair ' after a letter (don't, it's)
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
    },
})

-- tex brackets are handled by LuaSnip autosnippets (luasnippets/tex.lua),
-- and LaTeX quotes are ``like this'', so leave pairing off there
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    callback = function() vim.b.minipairs_disable = true end,
})
