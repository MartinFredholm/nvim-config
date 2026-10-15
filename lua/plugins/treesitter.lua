vim.pack.add({
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
})

-- Parsers beyond the ones bundled with Neovim (lua, markdown, vim, vimdoc, query, c).
-- LaTeX is left to vimtex. Already-installed parsers are skipped.
require('nvim-treesitter').install({ 'python', 'yaml', 'bash', 'json', 'matlab', 'latex', 'html' })

-- Treesitter highlighting wherever a parser exists
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        pcall(vim.treesitter.start, ev.buf)
    end,
})

-- Text objects: vaf, vif, vac, vic, daf, ...
require('nvim-treesitter-textobjects').setup({ select = { lookahead = true } })

local function select(obj)
    return function()
        require('nvim-treesitter-textobjects.select').select_textobject(obj, 'textobjects')
    end
end

vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        if ev.match == 'tex' then return end -- vimtex handles LaTeX
        pcall(vim.treesitter.start, ev.buf)
    end,
})

vim.keymap.set({ 'x', 'o' }, 'af', select('@function.outer'))
vim.keymap.set({ 'x', 'o' }, 'if', select('@function.inner'))
vim.keymap.set({ 'x', 'o' }, 'ac', select('@class.outer'))
vim.keymap.set({ 'x', 'o' }, 'ic', select('@class.inner'))
