vim.pack.add({
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})
require('render-markdown').setup({
    -- Render in every mode, including insert and visual
    render_modes = true,
    -- Show raw Markdown only on the line the cursor is on
    anti_conceal = {
        enabled = true,
        above = 0, -- lines above the cursor to also show raw
        below = 0, -- lines below the cursor to also show raw
    },
    code = {
        style = 'language',
    },
})
