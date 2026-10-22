require("config.glass").load("carbonfox-glass", "carbonfox", function(on)
  require("nightfox").setup({ options = { transparent = on } })
end)
