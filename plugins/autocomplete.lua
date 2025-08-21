nvim.pack.add({
    { src ='https://github.com/saghen/blink.cmp',version = '1.*'},
    { src ='https://github.com/rafamadriz/friendly-snippets'},
    { src ='https://github.com/L3MON4D3/LuaSnip'}, 
})

require('blink.cmp').setup({
    opts = {
        keymap = { preset = 'default' },

        appearance = {
          nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = false } },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
})
