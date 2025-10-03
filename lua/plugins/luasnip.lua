vim.pack.add({
    { src = 'https://github.com/L3MON4D3/LuaSnip', name = 'luasnip', run = "make install_jsregexp" },
    { src = 'https://github.com/iurimateus/luasnip-latex-snippets.nvim' },
})
local ls = require('luasnip')
local types = require('luasnip.util.types')
-- Configure LuaSnip
ls.config.set_config({
    enable_autosnippets = true,
    -- Update more frequently for better responsiveness
    update_events = 'TextChanged,TextChangedI',
    -- Show current choice in choiceNodes
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "choiceNode", "Comment" } },
            },
        },
    },
})

-- Load Lua snippets from luasnippets directory (OS-agnostic)
require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/luasnippets" })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })
