-- Fuzzy finding, git, keymap cheat sheet, sessions, and jj/jk escape.

local function builtin(name, opts)
  return function() require("telescope.builtin")[name](opts or {}) end
end

-- Open the buffer picker and run `action(bufnr)` on the chosen buffer
local function pick_buffer(action)
  return function()
    local actions = require("telescope.actions")
    require("telescope.builtin").buffers({
      attach_mappings = function(prompt)
        actions.select_default:replace(function()
          local entry = require("telescope.actions.state").get_selected_entry()
          actions.close(prompt)
          action(entry.bufnr)
        end)
        return true
      end,
    })
  end
end

-- Git roots of recently opened files; picking one cd's there and finds files
local function projects()
  local dirs, seen = {}, {}
  for _, file in ipairs(vim.v.oldfiles) do
    local root = vim.fs.root(file, ".git")
    if root and not seen[root] and vim.uv.fs_stat(root) then
      seen[root] = true
      table.insert(dirs, root)
    end
  end
  local actions = require("telescope.actions")
  require("telescope.pickers").new({}, {
    prompt_title = "Projects",
    finder = require("telescope.finders").new_table({
      results = dirs,
      entry_maker = function(dir)
        return { value = dir, display = vim.fn.fnamemodify(dir, ":~"), ordinal = dir }
      end,
    }),
    sorter = require("telescope.config").values.generic_sorter({}),
    attach_mappings = function(prompt)
      actions.select_default:replace(function()
        local entry = require("telescope.actions.state").get_selected_entry()
        actions.close(prompt)
        vim.fn.chdir(entry.value)
        require("telescope.builtin").find_files()
      end)
      return true
    end,
  }):find()
end

local everything = { hidden = true, no_ignore = true }

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      -- Find
      { "<leader>f<CR>", builtin("resume"), desc = "Resume previous search" },
      { "<leader>f'", builtin("marks"), desc = "Find marks" },
      { "<leader>fa", builtin("find_files", { cwd = vim.fn.stdpath("config") }), desc = "Find config files" },
      { "<leader>fb", builtin("buffers"), desc = "Find buffers" },
      { "<leader>fc", builtin("grep_string"), desc = "Find word under cursor" },
      { "<leader>fC", builtin("commands"), desc = "Find commands" },
      { "<leader>ff", builtin("find_files"), desc = "Find files" },
      { "<leader>fF", builtin("find_files", everything), desc = "Find all files" },
      { "<leader>fg", builtin("git_files"), desc = "Find git files" },
      { "<leader>fh", builtin("help_tags"), desc = "Find help" },
      { "<leader>fk", builtin("keymaps"), desc = "Find keymaps" },
      { "<leader>fl", builtin("current_buffer_fuzzy_find"), desc = "Find lines" },
      { "<leader>fm", builtin("man_pages"), desc = "Find man pages" },
      { "<leader>fo", builtin("oldfiles"), desc = "Find old files" },
      { "<leader>fO", builtin("oldfiles", { cwd_only = true }), desc = "Find old files (cwd)" },
      { "<leader>fp", projects, desc = "Find projects" },
      { "<leader>fr", builtin("registers"), desc = "Find registers" },
      { "<leader>fs", builtin("buffers", { sort_mru = true }), desc = "Find recent buffers" },
      { "<leader>ft", function() require("config.theme").pick() end, desc = "Find themes" },
      { "<leader>fw", builtin("live_grep"), desc = "Find words" },
      { "<leader>fW", builtin("live_grep", { additional_args = { "--hidden", "--no-ignore" } }), desc = "Find words in all files" },
      -- Git
      { "<leader>gb", builtin("git_branches"), desc = "Git branches" },
      { "<leader>gc", builtin("git_commits"), desc = "Git commits (repository)" },
      { "<leader>gC", builtin("git_bcommits"), desc = "Git commits (current file)" },
      { "<leader>gt", builtin("git_status"), desc = "Git status" },
      { "<leader>gT", builtin("git_stash"), desc = "Git stash" },
      -- Buffers
      { "<leader>bb", pick_buffer(function(b) vim.api.nvim_set_current_buf(b) end), desc = "Select buffer" },
      { "<leader>bd", pick_buffer(function(b) Snacks.bufdelete(b) end), desc = "Close buffer from picker" },
      { "<leader>b\\", pick_buffer(function(b) vim.cmd("sbuffer " .. b) end), desc = "Open buffer in horizontal split" },
      { "<leader>b|", pick_buffer(function(b) vim.cmd("vertical sbuffer " .. b) end), desc = "Open buffer in vertical split" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          file_ignore_patterns = { "node_modules/", "%.git/", "dist/", "build/" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
        },
        pickers = { find_files = { hidden = true } },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" }, change = { text = "~" }, delete = { text = "_" },
        topdelete = { text = "‾" }, changedelete = { text = "~" },
      },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = buf, desc = desc })
        end
        map("]g", function() gs.nav_hunk("next") end, "Next git hunk")
        map("[g", function() gs.nav_hunk("prev") end, "Previous git hunk")
        map("<leader>gl", gs.blame_line, "View git blame")
        map("<leader>gL", function() gs.blame_line({ full = true }) end, "View full git blame")
        map("<leader>gp", gs.preview_hunk_inline, "Preview git hunk")
        map("<leader>gh", gs.reset_hunk, "Reset git hunk")
        map("<leader>gr", gs.reset_buffer, "Reset git buffer")
        map("<leader>gs", gs.stage_hunk, "Stage/unstage git hunk")
        map("<leader>gS", gs.stage_buffer, "Stage git buffer")
        map("<leader>gd", gs.diffthis, "View git diff")
      end,
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      icons = { mappings = vim.g.have_nerd_font },
      win = { border = "rounded" },
      spec = {
        { "<leader>f", group = "Find" },
        { "<leader>l", group = "Language tools" },
        { "<leader>b", group = "Buffers" },
        { "<leader>bs", group = "Sort buffers" },
        { "<leader>g", group = "Git" },
        { "<leader>t", group = "Terminal" },
        { "<leader>u", group = "UI/UX" },
        { "<leader>p", group = "Packages" },
        { "<leader>x", group = "Quickfix/Lists" },
        { "<leader>S", group = "Session" },
      },
    },
  },
  {
    -- Saves a session per working directory on quit; restore it from the
    -- dashboard (s / S) or with the AstroNvim-style <leader>S keys
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      { "<leader>S.", function() require("persistence").load() end, desc = "Load current directory session" },
      { "<leader>Sl", function() require("persistence").load({ last = true }) end, desc = "Load last session" },
      { "<leader>Sf", function() require("persistence").select() end, desc = "Search sessions" },
      { "<leader>Ss", function() require("persistence").save() end, desc = "Save session" },
      { "<leader>Sd", function() require("persistence").stop() end, desc = "Don't save session on exit" },
    },
    init = function()
      -- The file tree would be restored as an empty window, so close it first
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistenceSavePre",
        callback = function() pcall(vim.cmd, "NvimTreeClose") end,
      })
    end,
    opts = {},
  },
  {
    -- jj / jk to leave insert mode, without lag when typing a normal "j"
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {},
  },
}
