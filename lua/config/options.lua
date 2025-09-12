-- Basics
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.incsearch = true

-- Visual
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.showmatch = true
vim.o.winborder = "rounded"
vim.opt.winblend = 0
vim.opt.pumblend = 0

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.schedule(function()
            vim.cmd("redraw!")
        end)
    end,
})
-- Force proper rendering
vim.api.nvim_create_autocmd("CompleteDone", {
    callback = function()
        vim.schedule(function()
            vim.cmd('redraw!')
        end)
    end,
})
-- File Handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.autoread = true
vim.o.autowrite = false

-- Behaviour Setting
vim.o.hidden = true
vim.o.autochdir = false
vim.opt.path = vim.opt.path + { ".", "**" }
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.conceallevel = 2

-- Behaviour
vim.o.spelllang = 'en_us'
vim.opt.showbreak = "↪ "
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})
