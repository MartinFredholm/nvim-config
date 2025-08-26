vim.pack.add({
    { src = "https://github.com/lervag/vimtex" },
})

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.g.vimtex_view_general_viewer = "SumatraPDF -reuse-instance"
end
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
