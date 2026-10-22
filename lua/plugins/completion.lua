-- Autocompletion popup fed by LSP, buffer words, paths and snippets.
return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- release tags ship a prebuilt fuzzy matcher
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      -- Toggled per buffer / globally with <leader>uc / <leader>uC
      enabled = function()
        return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.g.completion ~= false
      end,
      keymap = {
        preset = "none",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = { nerd_font_variant = "normal" },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { border = "single" },
        documentation = { auto_show = true, window = { border = "single" } },
      },
      signature = { enabled = true, window = { border = "single" } },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
