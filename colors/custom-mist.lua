-- custom-mist: a light theme for the misty stag wallpaper.
-- Fog-grey surfaces, a deep night-blue for text, and accents taken from the
-- picture: the stag's rust and umber, the pine-and-yellow of the treeline,
-- slate blue from the sky and a heather violet from the haze.
--
-- Install: save as ~/.config/nvim/colors/custom-mist.lua
-- Use:     :colorscheme custom-mist
--
-- Accents are kept dark and fairly desaturated so they stay readable over
-- the pale fog (roughly #c8cbe0 to #e4e6ef), which covers most of the image.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "light"
vim.g.colors_name = "custom-mist"

-- Set to false if you want a solid fog background instead of the wallpaper.
local transparent = true

local c = {
    bg                  = "#e4e6ef", -- pale fog: floats, and the background when transparent = false
    bg_alt              = "#c3c8d8", -- heavier fog: statusline, folds, color column
    bg_sel              = "#9fb4f0", -- misty blue: selection, menu selection
    fg                  = "#1b1f2a", -- night blue-black: normal text
    muted               = "#2f3542", -- punctuation, delimiters
    comment             = "#4d5566", -- slate grey
    faint               = "#6b7385", -- non-text, indent scope (decorative)
    brown               = "#786c02",
    rust                = "#c8280a", -- the stag's coat: keywords, operators
    umber               = "#8f4a00", -- the antlers: parameters, builtin variables, special
    red                 = "#d4001f", -- errors
    amber               = "#c96a00", -- warnings, git changes, regex
    yellow                = "#ffe91c", -- strings
    forest              = "#00893c", -- functions
    pine                = "#007a8c", -- types, builtins
    slate               = "#2350d8", -- links, info, directories
    heather             = "#8d22c9", -- constants, numbers

    -- Dashboard colors
    dashboard           = "#c8280a",
    dashboard_secondary = "#2350d8",
}

local none = "NONE"
local base_bg = transparent and none or c.bg

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
    -- Editor
    Normal                     = { fg = c.fg, bg = base_bg },
    NormalNC                   = { fg = c.fg, bg = base_bg },
    NormalFloat                = { fg = c.fg, bg = none },
    FloatBorder                = { fg = c.comment, bg = none },
    FloatTitle                 = { fg = c.rust, bg = c.bg, bold = true },
    SignColumn                 = { bg = base_bg },
    FoldColumn                 = { fg = c.faint, bg = base_bg },
    EndOfBuffer                = { fg = c.faint, bg = base_bg },
    LineNr                     = { fg = c.comment, bg = base_bg },
    CursorLineNr               = { fg = c.rust, bold = true },
    CursorLine                 = { bg = transparent and none or c.bg_alt },
    CursorColumn               = { bg = c.bg_alt },
    ColorColumn                = { bg = c.bg_alt },
    Visual                     = { bg = c.bg_sel },
    Search                     = { fg = c.fg, bg = "#ffc56b" },
    IncSearch                  = { fg = "#ffffff", bg = c.rust },
    CurSearch                  = { fg = "#ffffff", bg = c.rust },
    Substitute                 = { fg = "#ffffff", bg = c.red },
    MatchParen                 = { fg = c.rust, bold = true, underline = true },
    NonText                    = { fg = c.faint },
    Whitespace                 = { fg = c.faint },
    SpecialKey                 = { fg = c.faint },
    Conceal                    = { fg = c.comment },
    Folded                     = { fg = c.muted, bg = c.bg_alt },
    WinSeparator               = { fg = c.faint },
    VertSplit                  = { fg = c.faint },
    StatusLine                 = { fg = c.fg, bg = c.bg_alt },
    StatusLineNC               = { fg = c.comment, bg = none },
    TabLine                    = { fg = c.comment, bg = c.bg_alt },
    TabLineSel                 = { fg = c.fg, bg = c.bg, bold = true },
    TabLineFill                = { bg = c.bg_alt },
    WinBar                     = { fg = c.muted, bg = base_bg },
    Pmenu                      = { fg = c.fg, bg = none },
    PmenuSel                   = { fg = c.fg, bg = c.bg_sel, bold = true },
    PmenuKind                  = { fg = c.pine, bg = none },
    PmenuKindSel               = { fg = c.pine, bg = c.bg_sel },
    PmenuExtra                 = { fg = c.comment, bg = none },
    PmenuExtraSel              = { fg = c.comment, bg = c.bg_sel },
    PmenuMatch                 = { fg = c.rust, bold = true },
    PmenuMatchSel              = { fg = c.rust, bg = c.bg_sel, bold = true },
    PmenuSbar                  = { bg = c.bg_alt },
    PmenuThumb                 = { bg = c.faint },
    WildMenu                   = { fg = c.fg, bg = c.bg_sel },
    Directory                  = { fg = c.slate, bold = true },
    Title                      = { fg = c.rust, bold = true },
    ErrorMsg                   = { fg = c.red, bold = true },
    WarningMsg                 = { fg = c.amber, bold = true },
    ModeMsg                    = { fg = c.fg, bold = true },
    MoreMsg                    = { fg = c.forest },
    Question                   = { fg = c.forest },
    QuickFixLine               = { bg = c.bg_alt },
    SpellBad                   = { undercurl = true, sp = c.red },
    SpellCap                   = { undercurl = true, sp = c.amber },
    SpellRare                  = { undercurl = true, sp = c.heather },
    SpellLocal                 = { undercurl = true, sp = c.pine },

    -- Syntax
    Comment                    = { fg = c.comment, italic = true },
    Constant                   = { fg = c.heather },
    String                     = { fg = c.yellow },
    Character                  = { fg = c.yellow },
    Number                     = { fg = c.heather },
    Boolean                    = { fg = c.heather },
    Float                      = { fg = c.heather },
    Identifier                 = { fg = c.fg },
    Function                   = { fg = c.forest },
    Statement                  = { fg = c.rust },
    Conditional                = { fg = c.rust },
    Repeat                     = { fg = c.rust },
    Label                      = { fg = c.rust },
    Operator                   = { fg = c.rust },
    Keyword                    = { fg = c.rust },
    Exception                  = { fg = c.rust },
    PreProc                    = { fg = c.rust },
    Include                    = { fg = c.rust },
    Define                     = { fg = c.rust },
    Macro                      = { fg = c.pine },
    PreCondit                  = { fg = c.rust },
    Type                       = { fg = c.pine, italic = true },
    StorageClass               = { fg = c.rust },
    Structure                  = { fg = c.pine },
    Typedef                    = { fg = c.pine },
    Special                    = { fg = c.umber },
    SpecialChar                = { fg = c.umber },
    Tag                        = { fg = c.rust },
    Delimiter                  = { fg = c.muted },
    SpecialComment             = { fg = c.comment, bold = true },
    Debug                      = { fg = c.umber },
    Underlined                 = { underline = true },
    Error                      = { fg = c.red, bold = true },
    Todo                       = { fg = "#ffffff", bg = c.heather, bold = true },
    Added                      = { fg = c.forest },
    Changed                    = { fg = c.amber },
    Removed                    = { fg = c.red },

    -- Treesitter
    ["@variable"]              = { fg = c.fg },
    ["@variable.builtin"]      = { fg = c.umber, italic = true },
    ["@variable.parameter"]    = { fg = c.umber, italic = true },
    ["@variable.member"]       = { fg = c.fg },
    ["@constant"]              = { fg = c.heather },
    ["@constant.builtin"]      = { fg = c.heather, bold = true },
    ["@module"]                = { fg = c.slate },
    ["@string"]                = { fg = c.yellow },
    ["@string.escape"]         = { fg = c.heather },
    ["@string.regexp"]         = { fg = c.amber },
    ["@character"]             = { fg = c.yellow },
    ["@number"]                = { fg = c.heather },
    ["@boolean"]               = { fg = c.heather },
    ["@type"]                  = { fg = c.pine, italic = true },
    ["@type.builtin"]          = { fg = c.pine, italic = true },
    ["@attribute"]             = { fg = c.forest },
    ["@property"]              = { fg = c.fg },
    ["@function"]              = { fg = c.forest },
    ["@function.builtin"]      = { fg = c.pine },
    ["@function.call"]         = { fg = c.forest },
    ["@function.method"]       = { fg = c.forest },
    ["@function.macro"]        = { fg = c.pine },
    ["@constructor"]           = { fg = c.pine },
    ["@keyword"]               = { fg = c.rust },
    ["@keyword.function"]      = { fg = c.rust, italic = true },
    ["@keyword.return"]        = { fg = c.rust, bold = true },
    ["@operator"]              = { fg = c.rust },
    ["@punctuation"]           = { fg = c.muted },
    ["@punctuation.special"]   = { fg = c.rust },
    ["@comment"]               = { link = "Comment" },
    ["@tag"]                   = { fg = c.rust },
    ["@tag.attribute"]         = { fg = c.forest },
    ["@tag.delimiter"]         = { fg = c.muted },
    ["@markup.heading"]        = { fg = c.rust, bold = true },
    ["@markup.strong"]         = { bold = true },
    ["@markup.italic"]         = { italic = true },
    ["@markup.link"]           = { fg = c.slate, underline = true },
    ["@markup.raw"]            = { fg = c.yellow },
    ["@markup.math"]           = { fg = c.pine },
    ["@markup.list"]           = { fg = c.rust },
    ["@diff.plus"]             = { fg = c.forest },
    ["@diff.minus"]            = { fg = c.red },
    ["@diff.delta"]            = { fg = c.amber },

    -- LSP / diagnostics
    DiagnosticError            = { fg = c.red },
    DiagnosticWarn             = { fg = c.amber },
    DiagnosticInfo             = { fg = c.slate },
    DiagnosticHint             = { fg = c.heather },
    DiagnosticOk               = { fg = c.forest },
    DiagnosticUnderlineError   = { undercurl = true, sp = c.red },
    DiagnosticUnderlineWarn    = { undercurl = true, sp = c.amber },
    DiagnosticUnderlineInfo    = { undercurl = true, sp = c.slate },
    DiagnosticUnderlineHint    = { undercurl = true, sp = c.heather },
    DiagnosticVirtualTextError = { fg = c.red, italic = true },
    DiagnosticVirtualTextWarn  = { fg = c.amber, italic = true },
    DiagnosticVirtualTextInfo  = { fg = c.slate, italic = true },
    DiagnosticVirtualTextHint  = { fg = c.heather, italic = true },
    LspReferenceText           = { bg = c.bg_sel },
    LspReferenceRead           = { bg = c.bg_sel },
    LspReferenceWrite          = { bg = c.bg_sel, bold = true },
    LspInlayHint               = { fg = c.comment, italic = true },

    -- Diff
    DiffAdd                    = { bg = "#cfdccb" },
    DiffChange                 = { bg = "#d6d0c2" },
    DiffDelete                 = { fg = c.red, bg = "#e2c8c6" },
    DiffText                   = { bg = "#d9c3a3", bold = true },

    -- Dashboard
    DashboardHeader            = { fg = c.dashboard },
    DashboardIcon              = { fg = c.dashboard_secondary },
    DashboardDesc              = { fg = c.dashboard_secondary },
    DashboardKey               = { fg = c.umber, bold = true },
    DashboardFooter            = { fg = c.comment, italic = true },

    -- Common plugins
    GitSignsAdd                = { fg = c.forest, bg = base_bg },
    GitSignsChange             = { fg = c.amber, bg = base_bg },
    GitSignsDelete             = { fg = c.red, bg = base_bg },
    FzfLuaBorder               = { link = "FloatBorder" },
    FzfLuaTitle                = { link = "FloatTitle" },
    OilDir                     = { fg = c.slate, bold = true },
    IblIndent                  = { fg = c.bg_alt },
    IblScope                   = { fg = c.faint },

    -- render-markdown headings: stag to forest, top to bottom
    RenderMarkdownH1           = { fg = c.rust, bold = true },
    RenderMarkdownH2           = { fg = c.umber, bold = true },
    RenderMarkdownH3           = { fg = c.forest, bold = true },
    RenderMarkdownH4           = { fg = c.pine, bold = true },
    RenderMarkdownH5           = { fg = c.slate, bold = true },
    RenderMarkdownH6           = { fg = c.heather, bold = true },
    RenderMarkdownCode         = { bg = transparent and none or c.bg_alt },
}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal colors for :terminal
local term = {
    c.fg, c.red, c.forest, c.amber, c.slate, c.heather, c.pine, c.muted,
    c.comment, c.rust, c.yellow, c.umber, c.slate, c.heather, c.pine, c.fg,
}
for i, col in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = col end
