local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false

-- Indentation (2 spaces is the web dev norm; LSP/formatters/editorconfig override per project)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Layout
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }

-- Show tabs and trailing whitespace
opt.list = true
opt.listchars = { tab = "> ", trail = "-", nbsp = "+" }
