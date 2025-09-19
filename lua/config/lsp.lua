-- LSP setup
vim.lsp.enable({
    'lua_ls',
    'pyright',
    'yamlls',
})

-- Diagnostics
vim.diagnostic.config({

    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})

vim.cmd("set completeopt+=noselect")
