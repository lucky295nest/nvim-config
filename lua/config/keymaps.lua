-- Core keymaps, laid out like AstroNvim (https://docs.astronvim.com/mappings).
-- Plugin-specific keys live with their plugin in lua/plugins/*.lua.
-- Already built into Neovim: ]q [q ]Q [Q (quickfix), ]l [l ]L [L (loclist),
-- ]d [d (diagnostics), grr gri gra grn grt gO (LSP), gcc / gc (comments).

local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
map("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
map("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })
map("n", "|", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "\\", "<cmd>split<CR>", { desc = "Horizontal split" })

-- General
map({ "n", "i", "x" }, "<C-s>", "<cmd>silent! update! | redraw<CR>", { desc = "Force write" })
map("n", "<C-q>", "<cmd>q!<CR>", { desc = "Force quit" })
map("n", "<leader>q", "<cmd>confirm q<CR>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>confirm qall<CR>", { desc = "Exit Neovim" })
map("n", "<leader>n", "<cmd>enew<CR>", { desc = "New file" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

-- Tabs (real vim tabs)
map("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })

-- Buffers
map("n", "<leader>bp", "<cmd>buffer #<CR>", { desc = "Previous buffer" })

-- Comments
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle comment line" })
map("x", "<leader>/", "gc", { remap = true, desc = "Toggle comment" })
map("n", "gco", "o<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>", { desc = "Add comment below" })
map("n", "gcO", "O<Esc>Vcx<Esc><cmd>normal gcc<CR>fxa<BS>", { desc = "Add comment above" })

-- Lists
map("n", "<leader>xq", "<cmd>copen<CR>", { desc = "Quickfix list" })
map("n", "<leader>xl", "<cmd>lopen<CR>", { desc = "Location list" })

-- Diagnostics
local function jump(count, severity)
  return function()
    vim.diagnostic.jump({ count = count, severity = severity, float = true })
  end
end
local sev = vim.diagnostic.severity
map("n", "gl", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Hover diagnostics" })
map("n", "]e", jump(1, sev.ERROR), { desc = "Next error" })
map("n", "[e", jump(-1, sev.ERROR), { desc = "Previous error" })
map("n", "]w", jump(1, sev.WARN), { desc = "Next warning" })
map("n", "[w", jump(-1, sev.WARN), { desc = "Previous warning" })

-- Packages
map("n", "<leader>pi", "<cmd>Lazy install<CR>", { desc = "Plugins install" })
map("n", "<leader>ps", "<cmd>Lazy<CR>", { desc = "Plugins status" })
map("n", "<leader>pS", "<cmd>Lazy sync<CR>", { desc = "Plugins sync" })
map("n", "<leader>pu", "<cmd>Lazy check<CR>", { desc = "Plugins check updates" })
map("n", "<leader>pU", "<cmd>Lazy update<CR>", { desc = "Plugins update" })
map("n", "<leader>pm", "<cmd>Mason<CR>", { desc = "Mason installer" })
map("n", "<leader>pM", "<cmd>MasonUpdate<CR>", { desc = "Mason update registry" })
map("n", "<leader>pa", "<cmd>MasonUpdate<CR><cmd>Lazy update<CR>", { desc = "Update Lazy and Mason" })

-- Keep selection when indenting
map("x", "<", "<gv")
map("x", ">", ">gv")
