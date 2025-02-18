return {
  "williamboman/mason.nvim",
  dependencies = {
    -- 'williamboman/mason-lspconfig.nvim',
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- NOTE: Mason LSP configuration is done directly in lsp.lua
    -- NOTE: Mason DAP configuration is done directly in dap.lua

    -- Enable Mason and configure icons
    require("mason").setup({
      ui = {
        icons = vim.g.have_nerd_font and {} or {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Install required tools (for linting, formatting, debugging etc.) from Mason
    require("mason-tool-installer").setup({
      ensure_installed = {
        "stylua", -- Used to format Lua code
        "markdownlint", -- Used to lint Markdown files
      },
    })
  end,
}
