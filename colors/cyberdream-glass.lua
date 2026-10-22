require("config.glass").load("cyberdream-glass", "cyberdream", function(on)
  require("cyberdream").setup({ transparent = on })
end)
