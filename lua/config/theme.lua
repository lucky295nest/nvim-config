-- Theme switching, like NvChad's theme picker. Whatever colorscheme is
-- active (via the picker or :colorscheme) is saved and restored on startup.
-- "vira" and the "-glass" schemes (colors/) are transparent; the rest come
-- from lua/plugins/themes.lua.

local M = {}

M.default = "vira"
local file = vim.fn.stdpath("state") .. "/colorscheme"

function M.is_transparent()
  local name = vim.g.colors_name or ""
  return name == "vira" or name:match("%-glass$") ~= nil
end

local function fg(group)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  return hl.fg and string.format("#%06x", hl.fg) or nil
end

-- Palette for the transparent statusline/tabline: Vira's own colours, or
-- the same roles picked from the active scheme's highlight groups.
function M.colors()
  local palette = require("config.palette")
  if vim.g.colors_name == "vira" then return palette end
  local picked = {
    fg = fg("Normal"),
    gray = fg("LineNr"),
    comment = fg("Comment"),
    dim = fg("Comment"),
    red = fg("DiagnosticError"),
    green = fg("String"),
    yellow = fg("DiagnosticWarn"),
    blue = fg("Function"),
    magenta = fg("Keyword") or fg("Statement"),
    cyan = fg("Type"),
    accent = fg("CursorLineNr"),
  }
  return vim.tbl_extend("force", palette, picked)
end

local function saved()
  local f = io.open(file, "r")
  if not f then return nil end
  local name = f:read("*l")
  f:close()
  return name
end

function M.load()
  local name = saved() or M.default
  if not pcall(vim.cmd.colorscheme, name) then vim.cmd.colorscheme(M.default) end

  local group = vim.api.nvim_create_augroup("SaveColorscheme", { clear = true })

  -- Light variants (e.g. catppuccin-latte) set background=light, and generic
  -- names (catppuccin, tokyonight, rose-pine, ...) pick their variant from
  -- 'background', so they'd stay light after previewing one. Reset it before
  -- each switch; light variants set it again themselves. colors_name is
  -- cleared first because changing 'background' reloads the current scheme.
  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = group,
    callback = function()
      if vim.o.background ~= "dark" then
        vim.g.colors_name = nil
        vim.o.background = "dark"
      end
    end,
  })

  -- The picker previews by switching colorschemes and restores the original
  -- on cancel, so the last event is always the one to keep.
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function(ev)
      local f = io.open(file, "w")
      if f then
        f:write(ev.match)
        f:close()
      end
    end,
  })
end

-- Live-preview picker: move to preview, <CR> to keep, <Esc> to cancel
function M.pick()
  require("telescope.builtin").colorscheme({ enable_preview = true, ignore_builtins = true })
end

return M
