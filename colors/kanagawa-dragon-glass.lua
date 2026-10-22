require("config.glass").load("kanagawa-dragon-glass", "kanagawa-dragon", function(on)
  require("kanagawa").setup({
    transparent = on,
    colors = { theme = { all = { ui = { bg_gutter = on and "none" or nil } } } },
  })
end)
