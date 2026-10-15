-- vim.pack has no `build` key: run the plugin's install step after install/update.
-- Must be defined before vim.pack.add so it catches the first install.
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'markdown-preview' and (kind == 'install' or kind == 'update') then
            if not ev.data.active then vim.cmd.packadd(name) end
            vim.fn['mkdp#util#install']()
        end
    end,
})

vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_browser = 'zen'
vim.g.mkdp_auto_close = 0
vim.g.mkdp_combine_preview = 1
vim.g.mkdp_math = 'katex'
vim.g.mkdp_preview_options = {
    custom_template_path = vim.fn.stdpath('config') .. '/lua/extras/mkdp-template.html',
    disable_sync_scroll = 0,
}

vim.pack.add({
    { src = 'https://github.com/iamcco/markdown-preview.nvim', name = 'markdown-preview' },
})

local function set_sync_scroll(disabled)
    local opts = vim.g.mkdp_preview_options
    opts.disable_sync_scroll = disabled
    vim.g.mkdp_preview_options = opts -- vim.g tables must be reassigned to take effect
end

vim.api.nvim_create_user_command('MarkdownPreviewScroll', function() set_sync_scroll(0) end, {})
vim.api.nvim_create_user_command('MarkdownPreviewNoScroll', function() set_sync_scroll(1) end, {})
