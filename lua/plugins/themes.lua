-- Extra colorschemes for the theme picker (<leader>ft). All lazy-loaded:
-- lazy.nvim loads a plugin the first time one of its colorschemes is used.
-- Transparent "-glass" variants of some of these live in colors/.

return {
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "EdenEast/nightfox.nvim", lazy = true },
  { "navarasu/onedark.nvim", lazy = true },
  { "sainnhe/everforest", lazy = true },
  { "Mofiqul/dracula.nvim", lazy = true },
  { "projekt0n/github-nvim-theme", name = "github-theme", lazy = true },
  -- Made with transparency in mind; used by the vague-glass / cyberdream-glass schemes
  { "vague2k/vague.nvim", lazy = true },
  { "scottmckendry/cyberdream.nvim", lazy = true },
}
