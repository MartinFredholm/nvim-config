vim.pack.add({
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/micangl/cmp-vimtex" },
})

if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
elseif vim.uv.os_uname().sysname == "Darwin" then
    vim.g.vimtex_view_method = "skim"
end


-- 2. MUTE VIMTEX BACKGROUND WARNINGS & LOG POPUPS
vim.g.vimtex_log_verbose = 1              -- Suppress log messages in the echo area
vim.g.vimtex_compiler_silent = 0          -- Tell the compiler wrapper to shut up
vim.g.vimtex_mappings_warning_enabled = 0 -- Disable any initialization warnings

-- 3. Your existing Quickfix overrides (Kept for safety)
vim.g.vimtex_quickfix_open_on_success = 0
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_complete_enable = 1
vim.g.vimtex_quickfix_ignore_filters = {
    'Overfull \\hbox',
    'Underfull \\hbox',
}

vim.g.vimtex_compiler_latexmk = {
    build_dir = '',
    callback = 1,
    continuous = 1,
    executable = 'latexmk',
    options = {
        '-pdf',
        '-interaction=nonstopmode',
        '-synctex=1',
    },
    quickfix = 0,
}


local cmp = require('cmp')

cmp.setup.filetype('tex', {
    sources = cmp.config.sources({
        { name = 'vimtex' },
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    }),
})
