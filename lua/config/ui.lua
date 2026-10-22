-- The "vira" and "-glass" themes (colors/) have no backgrounds, so the
-- terminal's own background (and Ghostty's glass blur) shows through. Other
-- themes from the picker keep their backgrounds. See lua/config/theme.lua.

-- Plugins that set their own backgrounds after the colorscheme loads
local transparent_groups = {
  "Normal", "NormalNC", "NormalFloat", "FloatBorder", "SignColumn",
  "EndOfBuffer", "StatusLine", "StatusLineNC", "TabLineFill", "Pmenu",
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer", "NvimTreeWinSeparator",
  "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder",
  "WhichKeyNormal", "WhichKeyBorder", "LazyNormal", "MasonNormal",
  "BlinkCmpMenu", "BlinkCmpMenuBorder", "BlinkCmpDoc", "BlinkCmpDocBorder",
  "BlinkCmpSignatureHelp", "BlinkCmpSignatureHelpBorder",
  "SnacksDashboardNormal", "SnacksNormal",
}

local function clear_backgrounds()
  if not require("config.theme").is_transparent() then return end
  for _, group in ipairs(transparent_groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    hl.bg = nil
    hl.ctermbg = nil
    vim.api.nvim_set_hl(0, group, hl)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("TransparentBackground", { clear = true }),
  callback = clear_backgrounds,
})
vim.api.nvim_create_autocmd("User", { pattern = "VeryLazy", callback = clear_backgrounds })

local icons = vim.g.have_nerd_font
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded" },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons and " " or "E",
      [vim.diagnostic.severity.WARN] = icons and " " or "W",
      [vim.diagnostic.severity.INFO] = icons and " " or "I",
      [vim.diagnostic.severity.HINT] = icons and "󰌵 " or "H",
    },
  },
})
