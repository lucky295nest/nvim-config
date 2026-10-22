-- Formatting with conform.nvim (prettier for web files). Formats on save;
-- <leader>uf / <leader>uF toggle that per buffer / globally.
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>lf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "x" },
        desc = "Format document",
      },
    },
    opts = {
      formatters_by_ft = require("languages").formatters,
      format_on_save = function(buf)
        if vim.g.autoformat == false or vim.b[buf].autoformat == false then return end
        return { timeout_ms = 1000, lsp_format = "fallback" }
      end,
    },
  },
}
