-- unokai-light: a light counterpart to Neovim's built-in unokai,
-- tuned to stay readable on top of light wallpapers (transparent background).
--
-- Install: save as ~/.config/nvim/colors/unokai-light.lua
-- Use:     :colorscheme unokai-light
--
-- Every accent below clears ~4.5:1 contrast against #e0e0e0 and ~4:1
-- against #d0d0d0, so text stays legible over bright patches of the image.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "light"
vim.g.colors_name = "custom-light"

-- Set to false if you want a solid background instead of the wallpaper.
local transparent = true

local c = {
  bg       = "#f4f1ea", -- used for floats/popups and when transparent = false
  bg_alt   = "#d3cfc5", -- cursorline, statusline, selections
  bg_sel    = "#ff8e8e",
  fg       = "#1c1c1c",
  muted    = "#4a4a4a",
  comment  = "#5f5f66",
  faint    = "#8a8a90", -- non-text, indent guides (decorative only)
  pink     = "#c0004e", -- keywords, operators (unokai's pink)
  red      = "#b3001b",
  orange   = "#a44200",
  yellow   = "#7d5c00", -- types, classes
  green    = "#3a6e00", -- functions
  cyan     = "#006b80", -- builtins, special
  purple   = "#6a35b0", -- constants, numbers
  string   = "#7d5c00",

  -- Dashboard colors
  dashboard           = "#ee0b0b",
  dashboard_secondary = "#f5c542",
}

local none = "NONE"
local base_bg = transparent and none or c.bg

local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

local groups = {
  -- Editor
  Normal        = { fg = c.fg, bg = base_bg },
  NormalNC      = { fg = c.fg, bg = base_bg },
  NormalFloat   = { fg = c.fg, bg = none },
  FloatBorder   = { fg = c.comment, bg = none },
  FloatTitle    = { fg = c.pink, bg = c.bg, bold = true },
  SignColumn    = { bg = base_bg },
  FoldColumn    = { fg = c.faint, bg = base_bg },
  EndOfBuffer   = { fg = c.faint, bg = base_bg },
  LineNr        = { fg = c.comment, bg = base_bg },
  CursorLineNr  = { fg = c.fg, bold = true },
  CursorLine    = { bg = transparent and none or c.bg_alt },
  CursorColumn  = { bg = c.bg_alt },
  ColorColumn   = { bg = c.bg_alt },
  Visual        = { bg = c.bg_sel },
  Search        = { fg = c.fg, bg = "#f0d27a" },
  IncSearch     = { fg = "#ffffff", bg = c.pink },
  CurSearch     = { fg = "#ffffff", bg = c.pink },
  Substitute    = { fg = "#ffffff", bg = c.red },
  MatchParen    = { fg = c.pink, bold = true, underline = true },
  NonText       = { fg = c.faint },
  Whitespace    = { fg = c.faint },
  SpecialKey    = { fg = c.faint },
  Conceal       = { fg = c.comment },
  Folded        = { fg = c.muted, bg = c.bg_alt },
  WinSeparator  = { fg = c.faint },
  VertSplit     = { fg = c.faint },
  StatusLine    = { fg = c.fg, bg = c.bg_alt },
  StatusLineNC  = { fg = c.comment, bg = none},
  TabLine       = { fg = c.comment, bg = c.bg_alt },
  TabLineSel    = { fg = c.fg, bg = c.bg, bold = true },
  TabLineFill   = { bg = c.bg_alt },
  WinBar        = { fg = c.muted, bg = base_bg },
  Pmenu         = { fg = c.fg, bg = none },
  PmenuSel      = { fg = c.fg, bg = c.bg_sel, bold = true },
  PmenuSbar     = { bg = c.bg_alt },
  PmenuThumb    = { bg = c.faint },
  WildMenu      = { fg = c.fg, bg = c.bg_sel },
  Directory     = { fg = c.orange },
  Title         = { fg = c.pink, bold = true },
  ErrorMsg      = { fg = c.red, bold = true },
  WarningMsg    = { fg = c.orange, bold = true },
  ModeMsg       = { fg = c.fg, bold = true },
  MoreMsg       = { fg = c.green },
  Question      = { fg = c.green },
  QuickFixLine  = { bg = c.bg_alt },
  SpellBad      = { undercurl = true, sp = c.red },
  SpellCap      = { undercurl = true, sp = c.yellow },
  SpellRare     = { undercurl = true, sp = c.purple },
  SpellLocal    = { undercurl = true, sp = c.cyan },

  -- Syntax
  Comment       = { fg = c.comment, italic = true },
  Constant      = { fg = c.purple },
  String        = { fg = c.string },
  Character     = { fg = c.string },
  Number        = { fg = c.purple },
  Boolean       = { fg = c.purple },
  Float         = { fg = c.purple },
  Identifier    = { fg = c.fg },
  Function      = { fg = c.green },
  Statement     = { fg = c.pink },
  Conditional   = { fg = c.pink },
  Repeat        = { fg = c.pink },
  Label         = { fg = c.pink },
  Operator      = { fg = c.pink },
  Keyword       = { fg = c.pink },
  Exception     = { fg = c.pink },
  PreProc       = { fg = c.pink },
  Include       = { fg = c.pink },
  Define        = { fg = c.pink },
  Macro         = { fg = c.cyan },
  PreCondit     = { fg = c.pink },
  Type          = { fg = c.cyan, italic = true },
  StorageClass  = { fg = c.pink },
  Structure     = { fg = c.cyan },
  Typedef       = { fg = c.cyan },
  Special       = { fg = c.orange },
  SpecialChar   = { fg = c.orange },
  Tag           = { fg = c.pink },
  Delimiter     = { fg = c.muted },
  SpecialComment= { fg = c.comment, bold = true },
  Debug         = { fg = c.orange },
  Underlined    = { underline = true },
  Error         = { fg = c.red, bold = true },
  Todo          = { fg = "#ffffff", bg = c.purple, bold = true },
  Added         = { fg = c.green },
  Changed       = { fg = c.orange },
  Removed       = { fg = c.red },

  -- Treesitter
  ["@variable"]            = { fg = c.fg },
  ["@variable.builtin"]    = { fg = c.orange, italic = true },
  ["@variable.parameter"]  = { fg = c.orange },
  ["@variable.member"]     = { fg = c.fg },
  ["@constant"]            = { fg = c.purple },
  ["@constant.builtin"]    = { fg = c.purple, bold = true },
  ["@module"]              = { fg = c.fg },
  ["@string"]              = { fg = c.string },
  ["@string.escape"]       = { fg = c.purple },
  ["@string.regexp"]       = { fg = c.orange },
  ["@character"]           = { fg = c.string },
  ["@number"]              = { fg = c.purple },
  ["@boolean"]             = { fg = c.purple },
  ["@type"]                = { fg = c.cyan, italic = true },
  ["@type.builtin"]        = { fg = c.cyan, italic = true },
  ["@attribute"]           = { fg = c.green },
  ["@property"]            = { fg = c.fg },
  ["@function"]            = { fg = c.green },
  ["@function.builtin"]    = { fg = c.cyan },
  ["@function.call"]       = { fg = c.green },
  ["@function.method"]     = { fg = c.green },
  ["@function.macro"]      = { fg = c.cyan },
  ["@constructor"]         = { fg = c.cyan },
  ["@keyword"]             = { fg = c.pink },
  ["@keyword.function"]    = { fg = c.cyan, italic = true },
  ["@keyword.return"]      = { fg = c.pink },
  ["@operator"]            = { fg = c.pink },
  ["@punctuation"]         = { fg = c.muted },
  ["@punctuation.special"] = { fg = c.pink },
  ["@comment"]             = { link = "Comment" },
  ["@tag"]                 = { fg = c.pink },
  ["@tag.attribute"]       = { fg = c.green },
  ["@tag.delimiter"]       = { fg = c.muted },
  ["@markup.heading"]      = { fg = c.pink, bold = true },
  ["@markup.strong"]       = { bold = true },
  ["@markup.italic"]       = { italic = true },
  ["@markup.link"]         = { fg = c.cyan, underline = true },
  ["@markup.raw"]          = { fg = c.string },
  ["@markup.list"]         = { fg = c.pink },
  ["@diff.plus"]           = { fg = c.green },
  ["@diff.minus"]          = { fg = c.red },
  ["@diff.delta"]          = { fg = c.orange },

  -- LSP / diagnostics
  DiagnosticError          = { fg = c.red },
  DiagnosticWarn           = { fg = c.orange },
  DiagnosticInfo           = { fg = c.cyan },
  DiagnosticHint           = { fg = c.purple },
  DiagnosticOk             = { fg = c.green },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn  = { undercurl = true, sp = c.orange },
  DiagnosticUnderlineInfo  = { undercurl = true, sp = c.cyan },
  DiagnosticUnderlineHint  = { undercurl = true, sp = c.purple },
  DiagnosticVirtualTextError = { fg = c.red, italic = true },
  DiagnosticVirtualTextWarn  = { fg = c.orange, italic = true },
  DiagnosticVirtualTextInfo  = { fg = c.cyan, italic = true },
  DiagnosticVirtualTextHint  = { fg = c.purple, italic = true },
  LspReferenceText         = { bg = c.bg_sel },
  LspReferenceRead         = { bg = c.bg_sel },
  LspReferenceWrite        = { bg = c.bg_sel, bold = true },
  LspInlayHint             = { fg = c.comment, italic = true },

  -- Diff
  DiffAdd       = { bg = "#d4e8c4" },
  DiffChange    = { bg = "#ece0c4" },
  DiffDelete    = { fg = c.red, bg = "#f0cccc" },
  DiffText      = { bg = "#e3cc96", bold = true },

  -- Dashboard 
  DashboardHeader = { fg = c.dashboard },
  DashboardIcon   = { fg = c.dashboard_secondary },
  DashboardDesc   = { fg = c.dashboard_secondary },
  DashboardKey    = { fg = c.dashboard_secondary },
  DashboardFooter = { fg = c.dashboard_secondary },

  -- Common plugins
  GitSignsAdd          = { fg = c.green, bg = base_bg },
  GitSignsChange       = { fg = c.orange, bg = base_bg },
  GitSignsDelete       = { fg = c.red, bg = base_bg },
  TelescopeNormal      = { link = "NormalFloat" },
  TelescopeBorder      = { link = "FloatBorder" },
  TelescopeSelection   = { link = "PmenuSel" },
  TelescopeMatching    = { fg = c.pink, bold = true },
  IblIndent            = { fg = c.bg_sel },
  IblScope             = { fg = c.faint },
}

for group, opts in pairs(groups) do hl(group, opts) end

-- Terminal colors for :terminal
local term = {
  c.fg, c.red, c.green, c.yellow, c.cyan, c.purple, c.cyan, c.muted,
  c.comment, c.pink, c.green, c.orange, c.cyan, c.purple, c.cyan, c.fg,
}
for i, col in ipairs(term) do vim.g["terminal_color_" .. (i - 1)] = col end
