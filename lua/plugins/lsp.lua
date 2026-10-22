-- LSP: Mason installs servers, nvim-lspconfig provides their default configs,
-- and Neovim's built-in vim.lsp.config / vim.lsp.enable wires them up.
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    opts = { ui = { border = "single" } },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local languages = require("languages")

      -- Completion capabilities for every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })
      -- Show CSS colours as a coloured dot before the value (like VS Code / NvChad)
      -- instead of painting the whole value's background
      vim.lsp.document_color.enable(true, nil, { style = "● " })

      for name, cfg in pairs(languages.servers) do
        if next(cfg) then
          vim.lsp.config(name, cfg)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(languages.servers),
        automatic_enable = true,
      })
      require("mason-tool-installer").setup({ ensure_installed = languages.tools })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeys", { clear = true }),
        callback = function(args)
          -- AstroNvim-style LSP keys (grr/gri/gra/grn/gO are Neovim built-ins)
          local map = function(keys, fn, desc, mode)
            vim.keymap.set(mode or "n", keys, fn, { buffer = args.buf, desc = desc })
          end
          local tb = require("telescope.builtin")
          map("gd", tb.lsp_definitions, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gy", tb.lsp_type_definitions, "Go to type definition")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>la", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("<leader>lA", function()
            vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
          end, "Source code action")
          map("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>lR", tb.lsp_references, "Search references")
          map("<leader>lh", vim.lsp.buf.signature_help, "Signature help")
          map("<leader>ls", tb.lsp_document_symbols, "Document symbols")
          map("<leader>lS", tb.lsp_document_symbols, "Symbols outline")
          map("<leader>lG", tb.lsp_dynamic_workspace_symbols, "Workspace symbols")
          map("<leader>lD", function() tb.diagnostics({ bufnr = 0 }) end, "Search diagnostics")
          map("<leader>lw", tb.diagnostics, "Workspace diagnostics")
          map("<leader>li", "<cmd>checkhealth vim.lsp<CR>", "LSP information")
        end,
      })
    end,
  },
}
