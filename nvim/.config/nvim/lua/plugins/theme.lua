return {
  "morhetz/gruvbox",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.background = "dark"
    vim.cmd("colorscheme gruvbox")
  end,
}

