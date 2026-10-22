require("config.glass").load("vague-glass", "vague", function(on)
  require("vague").setup({ transparent = on })
end)
