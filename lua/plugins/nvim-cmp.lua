vim.pack.add({
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },               -- LSP completions
    { src = "https://github.com/hrsh7th/cmp-buffer" },                 -- buffer words
    { src = "https://github.com/hrsh7th/cmp-path" },                   -- filesystem paths
    { src = "https://github.com/hrsh7th/cmp-cmdline" },                -- command-line completion
    { src = "https://github.com/onsails/lspkind.nvim" },               -- pretty icons
    { src = "https://github.com/lukas-reineke/cmp-under-comparator" }, -- better sorting
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },           -- for luasnip completion
})

local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text", -- show symbol + text
            maxwidth = 50,
            ellipsis_char = "…",
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),

    sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }),
    sorting = {
        comparators = {
            require("cmp.config.compare").offset,
            require("cmp.config.compare").exact,
            require("cmp.config.compare").score,
            require("cmp-under-comparator").under,
            require("cmp.config.compare").kind,
            require("cmp.config.compare").length,
            require("cmp.config.compare").order,
        },
    },

    view = {
        -- entries = "native"
    },

    experimental = {
        ghost_text = false, -- inline suggestions
    },
})

cmp.setup.filetype("markdown", {
    sources = cmp.config.sources({
        { name = "obsidian" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
        { name = "path" },
    })
})
