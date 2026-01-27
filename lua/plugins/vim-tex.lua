vim.pack.add({
    { src = "https://github.com/lervag/vimtex" },
    { src = "https://github.com/micangl/cmp-vimtex" },
})

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.g.vimtex_view_general_viewer = "SumatraPDF"
end
vim.g.vimtex_quickfix_open_on_success = 0
vim.g.vimtex_quickfix_open_on_warning=0
vim.g.vimtex_quickfix_mode=0
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_complete_enable = 1
vim.g.vimtex_quickfix_ignore_filters = {
  'Overfull \\hbox',
  'Underfull \\hbox',
}
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
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
  quickfix = 0, -- disable quickfix
}

