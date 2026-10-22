-- Vira Carbon, matched to the Ghostty terminal palette.
-- Backgrounds are left unset so the terminal's background shows through.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "vira"
vim.o.background = "dark"
vim.o.termguicolors = true

local c = require("config.palette")

local groups = {
  -- Editor
  Normal       = { fg = c.fg },
  NormalNC     = { fg = c.fg },
  NormalFloat  = { fg = c.fg },
  FloatBorder  = { fg = c.gray },
  FloatTitle   = { fg = c.accent, bold = true },
  Cursor       = { fg = "#0A0A0A", bg = c.accent },
  CursorLine   = { bg = c.subtle },
  CursorLineNr = { fg = c.accent, bold = true },
  LineNr       = { fg = c.gray },
  SignColumn   = {},
  ColorColumn  = { bg = c.subtle },
  EndOfBuffer  = { fg = c.gray },
  NonText      = { fg = c.gray },
  Whitespace   = { fg = c.gray },
  WinSeparator = { fg = c.gray },
  VertSplit    = { fg = c.gray },
  Folded       = { fg = c.comment, italic = true },
  FoldColumn   = { fg = c.gray },
  Visual       = { bg = c.sel },
  Search       = { fg = "#0A0A0A", bg = c.yellow },
  IncSearch    = { fg = "#0A0A0A", bg = c.accent },
  CurSearch    = { link = "IncSearch" },
  MatchParen   = { fg = c.accent, bold = true, underline = true },
  Pmenu        = { fg = c.fg },
  PmenuSel     = { bg = c.sel, bold = true },
  PmenuSbar    = { bg = c.subtle },
  PmenuThumb   = { bg = c.gray },
  StatusLine   = { fg = c.fg },
  StatusLineNC = { fg = c.comment },
  TabLine      = { fg = c.comment },
  TabLineFill  = {},
  TabLineSel   = { fg = c.fg, bold = true },
  WildMenu     = { link = "PmenuSel" },
  Title        = { fg = c.blue, bold = true },
  Directory    = { fg = c.blue },
  ErrorMsg     = { fg = c.red, bold = true },
  WarningMsg   = { fg = c.yellow },
  MoreMsg      = { fg = c.green },
  ModeMsg      = { fg = c.fg, bold = true },
  Question     = { fg = c.cyan },
  SpecialKey   = { fg = c.gray },
  Conceal      = { fg = c.comment },
  SpellBad     = { sp = c.red, undercurl = true },
  SpellCap     = { sp = c.yellow, undercurl = true },

  -- Syntax
  Comment      = { fg = c.comment, italic = true },
  Constant     = { fg = c.red },
  String       = { fg = c.green },
  Character    = { fg = c.green },
  Number       = { fg = c.red },
  Boolean      = { fg = c.red },
  Float        = { fg = c.red },
  Identifier   = { fg = c.fg },
  Function     = { fg = c.blue },
  Statement    = { fg = c.magenta },
  Keyword      = { fg = c.magenta },
  Conditional  = { fg = c.magenta },
  Repeat       = { fg = c.magenta },
  Exception    = { fg = c.magenta },
  Operator     = { fg = c.cyan },
  PreProc      = { fg = c.cyan },
  Include      = { fg = c.magenta },
  Type         = { fg = c.yellow },
  StorageClass = { fg = c.magenta },
  Structure    = { fg = c.yellow },
  Special      = { fg = c.cyan },
  Delimiter    = { fg = c.dim },
  Tag          = { fg = c.red },
  Underlined   = { underline = true },
  Error        = { fg = c.red },
  Todo         = { fg = c.accent, bold = true },

  -- Treesitter
  ["@variable"]           = { fg = c.fg },
  ["@variable.builtin"]   = { fg = c.red, italic = true },
  ["@variable.parameter"] = { fg = c.fg, italic = true },
  ["@variable.member"]    = { fg = c.fg },
  ["@property"]           = { fg = c.fg },
  ["@constant"]           = { fg = c.yellow },
  ["@constant.builtin"]   = { fg = c.red },
  ["@module"]             = { fg = c.yellow },
  ["@constructor"]        = { fg = c.yellow },
  ["@function.builtin"]   = { fg = c.cyan },
  ["@keyword.return"]     = { fg = c.magenta, italic = true },
  ["@punctuation"]        = { fg = c.dim },
  ["@punctuation.special"] = { fg = c.cyan },
  ["@string.escape"]      = { fg = c.cyan },
  ["@string.special.url"] = { fg = c.cyan, underline = true },
  ["@tag"]                = { fg = c.red },
  ["@tag.builtin"]        = { fg = c.red },
  ["@tag.attribute"]      = { fg = c.yellow, italic = true },
  ["@tag.delimiter"]      = { fg = c.dim },
  ["@markup.heading"]     = { fg = c.blue, bold = true },
  ["@markup.link"]        = { fg = c.cyan },
  ["@markup.raw"]         = { fg = c.green },
  ["@markup.italic"]      = { italic = true },
  ["@markup.strong"]      = { bold = true },
  ["@lsp.type.property"]  = { link = "@property" },

  -- Diagnostics
  DiagnosticError = { fg = c.red },
  DiagnosticWarn  = { fg = c.yellow },
  DiagnosticInfo  = { fg = c.blue },
  DiagnosticHint  = { fg = c.cyan },
  DiagnosticOk    = { fg = c.green },
  DiagnosticUnderlineError = { sp = c.red, undercurl = true },
  DiagnosticUnderlineWarn  = { sp = c.yellow, undercurl = true },
  DiagnosticUnderlineInfo  = { sp = c.blue, undercurl = true },
  DiagnosticUnderlineHint  = { sp = c.cyan, undercurl = true },
  LspInlayHint    = { fg = c.comment, italic = true },

  -- Git / diff
  DiffAdd      = { fg = c.green },
  DiffChange   = { fg = c.yellow },
  DiffDelete   = { fg = c.red },
  DiffText     = { fg = c.blue, bold = true },
  Added        = { fg = c.green },
  Changed      = { fg = c.yellow },
  Removed      = { fg = c.red },
  GitSignsAdd    = { fg = c.green },
  GitSignsChange = { fg = c.yellow },
  GitSignsDelete = { fg = c.red },

  -- File tree
  NvimTreeNormal       = { fg = c.fg },
  NvimTreeNormalNC     = { fg = c.fg },
  NvimTreeFolderName   = { fg = c.blue },
  NvimTreeOpenedFolderName = { fg = c.blue, bold = true },
  NvimTreeFolderIcon   = { fg = c.blue },
  NvimTreeRootFolder   = { fg = c.accent, bold = true },
  NvimTreeIndentMarker = { fg = c.gray },
  NvimTreeGitDirtyIcon = { fg = c.yellow },
  NvimTreeGitNewIcon   = { fg = c.green },
  NvimTreeGitDeletedIcon = { fg = c.red },
  NvimTreeSpecialFile  = { fg = c.accent },

  -- Telescope
  TelescopeBorder       = { fg = c.gray },
  TelescopeTitle        = { fg = c.accent, bold = true },
  TelescopePromptPrefix = { fg = c.accent },
  TelescopeSelection    = { bg = c.sel },
  TelescopeMatching     = { fg = c.accent, bold = true },

  -- Completion
  BlinkCmpMenuBorder  = { fg = c.gray },
  BlinkCmpDocBorder   = { fg = c.gray },
  BlinkCmpSignatureHelpBorder = { fg = c.gray },
  BlinkCmpLabelMatch  = { fg = c.accent, bold = true },
  BlinkCmpKind        = { fg = c.magenta },

  -- Which-key
  WhichKey      = { fg = c.cyan },
  WhichKeyGroup = { fg = c.magenta },
  WhichKeyDesc  = { fg = c.fg },
  WhichKeySeparator = { fg = c.gray },

  -- Start screen (snacks dashboard)
  SnacksDashboardHeader  = { fg = c.accent },
  SnacksDashboardIcon    = { fg = c.blue },
  SnacksDashboardDesc    = { fg = c.fg },
  SnacksDashboardKey     = { fg = c.magenta, bold = true },
  SnacksDashboardTitle   = { fg = c.cyan, bold = true },
  SnacksDashboardFile    = { fg = c.fg },
  SnacksDashboardDir     = { fg = c.comment },
  SnacksDashboardFooter  = { fg = c.comment, italic = true },
  SnacksDashboardSpecial = { fg = c.accent },
}

for name, spec in pairs(groups) do
  vim.api.nvim_set_hl(0, name, spec)
end

-- Terminal buffers use the same palette as Ghostty
local term = {
  c.gray, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.fg,
  c.gray, c.red, c.green, c.yellow, c.blue, c.magenta, c.cyan, c.white,
}
for i, color in ipairs(term) do
  vim.g["terminal_color_" .. (i - 1)] = color
end

