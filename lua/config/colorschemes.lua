-- Theme
vim.cmd.colorscheme("unokai")
-- Make backgrounds transparant
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
vim.api.nvim_set_hl(0, "PmenuKind", { bg = "none" })
-- Apply custom color to dashboard
local dashboard_color = "#e40b0b"
local dashboard_color_secondary = "#f5c542"
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = dashboard_color })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = dashboard_color_secondary })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = dashboard_color_secondary })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = dashboard_color_secondary })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = dashboard_color_secondary })
-- Custom spell highlights (overrides unokai defaults)
vim.api.nvim_set_hl(0, "SpellBad", { underline = true})
vim.api.nvim_set_hl(0, "SpellCap", { underline = true})
vim.api.nvim_set_hl(0, "SpellLocal", { underline = true})
vim.api.nvim_set_hl(0, "SpellRare", { underline = true})

