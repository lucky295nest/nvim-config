require("config.glass").load("catppuccin-mocha-glass", "catppuccin-mocha", function(on)
  require("catppuccin").setup({ transparent_background = on, float = { transparent = on } })
end)
