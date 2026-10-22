-- Leader must be set before plugins load so their mappings use it.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Set to true if your terminal uses a Nerd Font (enables file icons).
vim.g.have_nerd_font = true

require("config.options")
require("config.keymaps")
require("config.ui")
require("config.lazy")
require("config.theme").load()
