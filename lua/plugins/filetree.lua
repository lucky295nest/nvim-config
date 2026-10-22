-- File tree sidebar. <leader>e toggles it, <leader>o jumps between it and the code.
return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
    dependencies = { { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font } },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle explorer" },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "NvimTree" then
            vim.cmd.wincmd("p")
          else
            vim.cmd("NvimTreeFindFile")
          end
        end,
        desc = "Toggle explorer focus",
      },
    },
    init = function()
      -- nvim-tree replaces netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      view = { width = 32 },
      filters = { dotfiles = false, custom = { "^.git$", "^node_modules$" } },
      git = { ignore = false },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = vim.g.have_nerd_font,
            folder = vim.g.have_nerd_font,
            folder_arrow = true,
            git = true,
          },
          glyphs = vim.g.have_nerd_font and {} or {
            folder = { arrow_closed = "+", arrow_open = "-" },
            git = {
              unstaged = "M", staged = "S", unmerged = "U", renamed = "R",
              untracked = "?", deleted = "D", ignored = "!",
            },
          },
        },
      },
    },
  },
}
