require("config.glass").load("tokyonight-night-glass", "tokyonight-night", function(on)
  local bg = on and "transparent" or "dark"
  require("tokyonight").setup({ transparent = on, styles = { sidebars = bg, floats = bg } })
end)
