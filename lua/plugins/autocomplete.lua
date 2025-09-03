vim.pack.add({
    { src = 'https://github.com/saghen/blink.cmp',            version = 'v1.6.0' },
    { src = 'https://github.com/saghen/blink.compat',         version = 'v2.5.0' },
})

require("blink.cmp").setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lsp = { name = 'lsp' },
            path = { name = 'path' },
            snippets = { name = 'snippets' },
            buffer = { name = 'buffer' },
        },
    },
    snippets = {
        preset = 'luasnip',
        expand = function(snippet)
            require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
            if filter and filter.direction then
                return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
        end,
        jump = function(direction)
            require('luasnip').jump(direction)
        end,
    },
    fuzzy = { implementation = "lua" },
})
