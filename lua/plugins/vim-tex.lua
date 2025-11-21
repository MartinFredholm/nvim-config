vim.pack.add({
    { src = "https://github.com/lervag/vimtex" },
})

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
end
vim.g.vimtex_complete_enable = 1
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_quickfix_ignore_filters = {
  'Overfull \\hbox',
  'Underfull \\hbox',
}
vim.g.vimtex_quickfix_open_on_warning=0
vim.g.vimtex_quickfix_mode=0
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
