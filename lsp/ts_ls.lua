local global_ts = vim.fn.trim(vim.fn.system("npm root -g")) .. "/typescript/lib"

---@type vim.lsp.Config
return {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript', 'javascriptreact',
        'typescript', 'typescriptreact',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
    init_options = {
        hostInfo = 'neovim',
        tsserver = { path = global_ts },
    },
}
