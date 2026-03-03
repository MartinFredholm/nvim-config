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
    bg = hsl(214, 31, 10),
    fg = hsl(96, 15, 95),
}

local highlights = {
    Normal = { fg = color.fg, bg = color.bg },
}

function M.setup()
    for group, opt in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, opt)
    end
end

return M
