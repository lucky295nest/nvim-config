-- ============================================================================
-- Language support lives here. To add a language, extend these three tables:
--
--   parsers     Treesitter grammars (syntax highlighting / indentation).
--               List: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
--   servers     LSP servers, by nvim-lspconfig name (installed via Mason).
--               List: :help lspconfig-all   (or :Mason to browse)
--               Value is extra config passed to vim.lsp.config(), or {}.
--   formatters  Formatters per filetype (installed via Mason, run by conform.nvim).
--               `tools` lists the Mason package names to install.
--
-- Example — adding Python:
--   parsers:    "python"
--   servers:    pyright = {},
--   formatters: python = { "ruff_format" },   tools: "ruff"
-- ============================================================================

local M = {}

M.parsers = {
  -- web
  "html", "css", "scss", "javascript", "typescript", "tsx", "jsdoc",
  "json", "graphql", "vue", "svelte", "astro",
  -- general
  "lua", "luadoc", "vim", "vimdoc", "query", "markdown", "markdown_inline",
  "bash", "yaml", "toml", "regex", "diff", "gitcommit", "dockerfile",
}

M.servers = {
  ts_ls = {},                 -- TypeScript / JavaScript
  html = {},
  cssls = {},
  jsonls = {},
  eslint = {},
  tailwindcss = {},
  emmet_language_server = {}, -- HTML/JSX abbreviation expansion
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
        diagnostics = { globals = { "vim" } },
      },
    },
  },
}

local web = { "prettierd", "prettier", stop_after_first = true }

M.formatters = {
  javascript = web,
  javascriptreact = web,
  typescript = web,
  typescriptreact = web,
  vue = web,
  svelte = web,
  html = web,
  css = web,
  scss = web,
  json = web,
  jsonc = web,
  yaml = web,
  markdown = web,
  graphql = web,
  lua = { "stylua" },
}

-- Mason packages for formatters/linters (LSP servers are installed automatically)
M.tools = { "prettierd", "stylua" }

return M
