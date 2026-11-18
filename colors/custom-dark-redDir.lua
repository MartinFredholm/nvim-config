-- custom-unokai: Neovim's built-in unokai written out with explicit colors,
-- plus your tweaks (transparent background, dashboard colors, plain spell
-- underlines). Palette and roles taken from runtime/colors/unokai.vim.
--
-- Install: save as ~/.config/nvim/colors/custom-unokai.lua
-- Use:     vim.cmd.colorscheme("custom-unokai")

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.g.colors_name = "custom-unokai"

-- Set to false if you want unokai's solid background instead of the wallpaper.
local transparent = true

local c = {
  bg       = "#282923", -- unokai background (used when transparent = false)
  bg_alt   = "#3a392f", -- cursorline, cursorcolumn
  bg_float = "#585858", -- color column, menus when not transparent
  bg_sel   = "#8a8a8a", -- menu selection
  fg       = "#f8f8f2",
  fg_alt   = "#dadada", -- cursor line number, todo
  muted    = "#bababa", -- statusline, folded text
  comment  = "#74705d",
  faint    = "#8a8a8a", -- line numbers, non-text
  pink     = "#f92672", -- keywords, operators, preproc
  red      = "#d75f5f", -- removed, spelling
  orange   = "#fd971f", -- types, matching paren
  peach    = "#ffaf5f", -- search, changed
  yellow   = "#e6db74", -- strings, labels
  green    = "#a6e22e", -- functions
  green_dk = "#81af24", -- messages
  cyan     = "#66d9ef", -- identifiers, links
  aqua     = "#a1efe4", -- directories, selection
  teal     = "#80beb5", -- special, builtins
  purple   = "#ae81ff", -- constants, numbers
  magenta  = "#fd5ff0",

  -- Dashboard colors
  dashboard           = "#ee0b0b",
  dashboard_secondary = "#f5c542",
}

local none = "NONE"
local base_bg = transparent and none or c.bg
local menu_bg = transparent and none or c.bg_float

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
  -- Editor
  Normal        = { fg = c.fg, bg = base_bg },
  NormalNC      = { fg = c.fg, bg = base_bg },
  NormalFloat   = { fg = c.fg, bg = none },
  FloatBorder   = { fg = c.comment, bg = none },
  FloatTitle    = { fg = c.pink, bold = true },
  SignColumn    = { bg = none },
  FoldColumn    = { fg = c.faint, bg = none },
  EndOfBuffer   = { fg = c.faint, bg = none },
  LineNr        = { fg = c.faint },
  LineNrAbove   = { fg = c.faint },
  LineNrBelow   = { fg = c.faint },
  CursorLineNr  = { fg = c.fg_alt, bold = true },
  CursorLine    = { bg = c.bg_alt },
  CursorColumn  = { bg = c.bg_alt },
  ColorColumn   = { bg = c.bg_float },
  Visual        = { fg = c.bg, bg = c.aqua },
  VisualNOS     = { fg = c.bg, bg = c.teal },
  Search        = { fg = c.bg, bg = c.cyan },
  IncSearch     = { fg = c.bg, bg = c.peach },
  CurSearch     = { fg = c.bg, bg = c.peach },
  Substitute    = { fg = c.bg, bg = c.pink },
  MatchParen    = { fg = c.orange, bold = true },
  NonText       = { fg = c.faint },
  Whitespace    = { fg = c.faint },
  SpecialKey    = { fg = c.faint },
  Conceal       = { fg = c.faint },
  Folded        = { fg = c.muted, bg = "#414141" },
  WinSeparator  = { fg = c.comment },
  VertSplit     = { fg = c.comment },
  StatusLine    = { fg = c.bg, bg = c.muted },
  StatusLineNC  = { fg = c.bg, bg = c.comment },
  TabLine       = { fg = c.bg, bg = c.comment },
  TabLineSel    = { fg = c.bg, bg = c.muted, bold = true },
  TabLineFill   = { fg = c.bg, bg = c.comment },
  WinBar        = { fg = c.muted, bg = none },
  Pmenu         = { fg = c.fg, bg = menu_bg },
  PmenuSel      = { bg = c.bg_sel },
  PmenuKind     = { fg = c.teal, bg = menu_bg },
  PmenuKindSel  = { fg = c.teal, bg = c.bg_sel },
  PmenuExtra    = { fg = c.muted, bg = menu_bg },
  PmenuExtraSel = { fg = c.muted, bg = c.bg_sel },
  PmenuMatch    = { fg = c.peach, bg = menu_bg },
  PmenuMatchSel = { fg = c.peach, bg = c.bg_sel },
  PmenuSbar     = { bg = none },
  PmenuThumb    = { bg = c.comment },
  WildMenu      = { fg = c.bg, bg = c.yellow, bold = true },
  Directory     = { fg = c.red, bold = true },
  Title         = { bold = true },
  ErrorMsg      = { fg = c.bg, bg = c.pink },
  WarningMsg    = { fg = c.pink },
  ModeMsg       = { bold = true },
  MoreMsg       = { fg = c.green_dk },
  Question      = { fg = c.yellow },
  QuickFixLine  = { fg = c.bg, bg = "#51aebe" },
  Cursor        = { fg = "#000000", bg = c.fg_alt },

  -- Spell: plain underlines (your override)
  SpellBad      = { underline = true },
  SpellCap      = { underline = true },
  SpellLocal    = { underline = true },
  SpellRare     = { underline = true },

  -- Syntax
  Comment       = { fg = c.comment },
  Constant      = { fg = c.purple },
  String        = { fg = c.yellow },
  Character     = { fg = c.green },
  Number        = { fg = c.purple },
  Boolean       = { fg = c.purple },
  Float         = { fg = c.purple },
  Identifier    = { fg = c.cyan },
  Function      = { fg = c.green },
  Statement     = { fg = c.pink, bold = true },
  Conditional   = { fg = c.pink, bold = true },
  Repeat        = { fg = c.pink, bold = true },
  Label         = { fg = c.yellow },
  Operator      = { fg = c.pink },
  Keyword       = { fg = c.pink, bold = true },
  Exception     = { fg = c.pink, bold = true },
  PreProc       = { fg = c.pink },
  Include       = { fg = c.pink },
  Define        = { fg = c.cyan },
  Macro         = { fg = c.pink },
  PreCondit     = { fg = c.pink },
  Type          = { fg = c.orange, bold = true },
  StorageClass  = { fg = c.pink },
  Structure     = { fg = c.pink },
  Typedef       = { fg = c.orange, bold = true },
  Special       = { fg = c.teal },
  SpecialChar   = { fg = c.teal },
  Tag           = { fg = c.teal },
  Delimiter     = { fg = c.pink },
  SpecialComment= { fg = c.teal },
  Debug         = { fg = c.teal },
  Underlined    = { fg = c.cyan, underline = true },
  Error         = { fg = c.bg, bg = c.pink },
  Todo          = { fg = c.fg_alt, bold = true },
  Added         = { fg = "#5fd75f" },
  Changed       = { fg = c.peach },
  Removed       = { fg = c.red },

  -- Treesitter
  ["@variable"]            = { fg = c.fg },
  ["@variable.builtin"]    = { fg = c.teal },
  ["@variable.parameter"]  = { fg = c.fg },
  ["@variable.member"]     = { fg = c.cyan },
  ["@constant"]            = { fg = c.purple },
  ["@constant.builtin"]    = { fg = c.purple },
  ["@module"]              = { fg = c.cyan },
  ["@string"]              = { fg = c.yellow },
  ["@string.escape"]       = { fg = c.teal },
  ["@string.regexp"]       = { fg = c.teal },
  ["@character"]           = { fg = c.green },
  ["@number"]              = { fg = c.purple },
  ["@boolean"]             = { fg = c.purple },
  ["@type"]                = { fg = c.orange, bold = true },
  ["@type.builtin"]        = { fg = c.orange, bold = true },
  ["@attribute"]           = { fg = c.teal },
  ["@property"]            = { fg = c.cyan },
  ["@function"]            = { fg = c.green },
  ["@function.builtin"]    = { fg = c.teal },
  ["@function.call"]       = { fg = c.green },
  ["@function.method"]     = { fg = c.green },
  ["@function.macro"]      = { fg = c.pink },
  ["@constructor"]         = { fg = c.teal },
  ["@keyword"]             = { fg = c.pink, bold = true },
  ["@keyword.function"]    = { fg = c.pink, bold = true },
  ["@keyword.return"]      = { fg = c.pink, bold = true },
  ["@operator"]            = { fg = c.pink },
  ["@punctuation"]         = { fg = c.pink },
  ["@punctuation.special"] = { fg = c.teal },
  ["@comment"]             = { link = "Comment" },
  ["@tag"]                 = { fg = c.pink },
  ["@tag.attribute"]       = { fg = c.green },
  ["@tag.delimiter"]       = { fg = c.fg },
  ["@markup.heading"]      = { fg = c.pink, bold = true },
  ["@markup.strong"]       = { bold = true },
  ["@markup.italic"]       = { italic = true },
  ["@markup.link"]         = { fg = c.cyan, underline = true },
  ["@markup.raw"]          = { fg = c.comment },
  ["@markup.list"]         = { fg = c.pink },
  ["@diff.plus"]           = { fg = "#5fd75f" },
  ["@diff.minus"]          = { fg = c.red },
  ["@diff.delta"]          = { fg = c.peach },

  -- LSP / diagnostics
  DiagnosticError          = { fg = c.pink },
  DiagnosticWarn           = { fg = c.orange },
  DiagnosticInfo           = { fg = c.cyan },
  DiagnosticHint           = { fg = c.teal },
  DiagnosticOk             = { fg = c.green },
  DiagnosticUnderlineError = { undercurl = true, sp = c.pink },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = c.cyan },
  DiagnosticUnderlineHint  = { undercurl = true, sp = c.teal },
  DiagnosticVirtualTextError = { fg = c.pink, italic = true },
  DiagnosticVirtualTextWarn  = { fg = c.orange, italic = true },
  DiagnosticVirtualTextInfo  = { fg = c.cyan, italic = true },
  DiagnosticVirtualTextHint  = { fg = c.teal, italic = true },
  LspReferenceText         = { bg = c.bg_alt },
  LspReferenceRead         = { bg = c.bg_alt },
  LspReferenceWrite        = { bg = c.bg_alt, bold = true },
  LspInlayHint             = { fg = c.comment, italic = true },

  -- Diff (unokai uses reversed colors)
  DiffAdd       = { fg = c.bg, bg = "#5faf5f" },
  DiffChange    = { fg = c.bg, bg = "#5f87af" },
  DiffDelete    = { fg = c.bg, bg = "#af5f5f" },
  DiffText      = { fg = c.bg, bg = "#af87af" },

  -- Dashboard 
  DashboardHeader = { fg = c.dashboard },
  DashboardIcon   = { fg = c.dashboard_secondary },
  DashboardDesc   = { fg = c.dashboard_secondary },
  DashboardKey    = { fg = c.dashboard_secondary },
  DashboardFooter = { fg = c.dashboard_secondary },

  -- Common plugins
  GitSignsAdd          = { fg = "#5fd75f", bg = none },
  GitSignsChange       = { fg = c.peach, bg = none },
  GitSignsDelete       = { fg = c.red, bg = none },
  TelescopeNormal      = { link = "NormalFloat" },
  TelescopeBorder      = { link = "FloatBorder" },
  TelescopeSelection   = { link = "PmenuSel" },
  TelescopeMatching    = { fg = c.peach, bold = true },
  IblIndent            = { fg = "#414141" },
  IblScope             = { fg = c.comment },

  -- Markdown headings (unokai's per-level colors)
  markdownH1Delimiter  = { fg = c.pink },
  markdownH2Delimiter  = { fg = c.yellow },
  markdownH3Delimiter  = { fg = c.orange },
  markdownH4Delimiter  = { fg = c.cyan },
  markdownH5Delimiter  = { fg = "#51aebe" },
  markdownH6Delimiter  = { fg = c.green },
  markdownCode         = { link = "Comment" },
}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal colors for :terminal (unokai's own ANSI set)
local term = {
  "#282923", "#c61e5c", "#81af24", "#fd971f", "#51aebe", "#ae81ff", "#80beb5", "#bababa",
  "#74705d", "#f92672", "#a6e22e", "#e6db74", "#66d9ef", "#fd5ff0", "#a1efe4", "#f8f8f2",
}
for i, col in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = col end
