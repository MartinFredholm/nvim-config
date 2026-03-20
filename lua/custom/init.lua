local M = {}

local function hsl(h, s, l)
    s = s / 100
    l = l / 100

    local function f(n)
        local k = (n + h / 30) % 12
        local a = s * math.min(l, 1 - l)
        return l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
    end

    local r = math.floor(f(0) * 255 + 0.5)
    local g = math.floor(f(8) * 255 + 0.5)
    local b = math.floor(f(4) * 255 + 0.5)

    return string.format("#%02x%02x%02x", r, g, b)
end

local color = {
    bg = hsl(115, 30, 5),
    fg = hsl(57, 20, 90),
    fg_mute = hsl(57, 20, 50),
    visual = hsl(50, 20, 30),
    statusline = hsl(135, 50, 74),
    mahogny = hsl(354, 66, 8),
    dashboard_color = "#e40b0b",
    dashboard_color_secondary = "#f5c542"
}

local highlights = {
    -- Base nvim colors
    Normal = { fg = color.fg, bg = color.bg },
    NormalNC = { fg = color.fg, bg = color.bg },
    NormalFloat = { fg = color.fg, bg = color.bg },
    Visual = { bg = color.visual },
    StatusLine = { bg = color.statusline, fg = color.bg},
    StatusLineNC = { bg = color.statusline, fg = color.bg},
    SignColumn = { bg = color.bg, fg = color.fg},
    LineNr = { bg = color.bg, fg = color.fg_mute},
    CursorLineNr = { bg = color.bg, fg = color.fg},
    -- Apply custom color to dashboard
    DashboardHeader = { fg = color.dashboard_color },
    DashboardIcon = { fg = color.dashboard_color_secondary },
    DashboardDesc = { fg = color.dashboard_color_secondary },
    DashboardKey = { fg = color.dashboard_color_secondary },
    DashboardFooter = { fg = color.dashboard_color_secondary },
    -- Custom spell highlights (overrides unokai defaults)
    SpellBad = { underline = true },
    SpellCap = { underline = true },
    SpellLocal = { underline = true },
    SpellRare = { underline = true },
}

function M.setup()
    for group, opt in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opt)
    end
end

return M
