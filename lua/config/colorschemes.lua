local profile = (vim.env.ITERM_PROFILE or ''):lower()
local light = profile:find('light') ~= nil
local popp = profile:find('popp') ~= nil

if light then
    vim.o.background = 'light'
    vim.cmd.colorscheme('custom-light')
elseif popp then
    vim.o.background = 'light'
    vim.cmd.colorscheme('custom-popp')
else
    vim.o.background = 'dark'
    vim.cmd.colorscheme('custom-dark')
end
