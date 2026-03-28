return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright", "gopls", "dartls", "html", "cssls" },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    vim.lsp.config("pyright", {
      cmd = { "pyright-langserver", "--stdio" },
      root_markers = { "pyproject.toml", "setup.py" },
    })

    vim.lsp.config("gopls", {
      cmd = { "gopls" },
      root_markers = { "go.mod" },
    })

    vim.lsp.config("dartls", {
      cmd = { "dart", "language-server", "--protocol=lsp" },
      root_markers = { "pubspec.yaml" },
    })

    vim.lsp.config("html", {
      cmd = { "html-languageserver", "--stdio" },
      root_markers = { ".html-validate.json" },
    })

    vim.lsp.config("cssls", {
      cmd = { "css-languageserver", "--stdio" },
      root_markers = { "package.json" },
    })

    vim.lsp.enable({ "pyright", "dartls", "html", "cssls" })
  end,
}

