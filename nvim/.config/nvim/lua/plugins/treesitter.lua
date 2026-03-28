return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "python",
        "go",
        "dart",
        "html",
        "css",
        "lua",
        "vim",
        "query",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

