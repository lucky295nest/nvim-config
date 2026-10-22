-- Builds the "-glass" colorschemes in colors/: an existing theme with its
-- backgrounds turned off, so Ghostty's glass blur shows through like vira.
-- Theme plugins keep their options globally, so the transparent setup is
-- undone right after loading; picking the plain theme stays opaque.

local M = {}

---@param name string the glass scheme's own name, e.g. "catppuccin-mocha-glass"
---@param base string the colorscheme to load underneath
---@param configure fun(transparent: boolean) calls the plugin's setup()
function M.load(name, base, configure)
  -- configure() requires the plugin, so lazy.nvim has it on 'runtimepath' by
  -- now. Its colors file is sourced directly: Neovim ignores a :colorscheme
  -- run from inside another colorscheme.
  configure(true)
  vim.cmd.runtime({ args = { "colors/" .. base .. ".lua", "colors/" .. base .. ".vim" } })
  configure(false)
  vim.g.colors_name = name
end

return M
