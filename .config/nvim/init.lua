-- =============== Basic Settings ===============
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true         -- allow truecolor and transparency
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.g.mapleader = " "

local map = vim.keymap.set
local opts = { silent = true, noremap = true }

-- =============== Transparency (let terminal opacity show) ===============
vim.cmd([[
  highlight Normal guibg=NONE
  highlight NormalFloat guibg=NONE
]])

-- =============== Bootstrap lazy.nvim ===============
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============== Plugins ===============
require("lazy").setup({
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30, side = "left" },
        git = { enable = true },
        filters = { dotfiles = false },
        update_focused_file = { enable = true },
        hijack_netrw = true,
      })
    end,
  },

  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "plenary.nvim" } },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "javascript", "typescript", "html", "css", "bash" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- LSP & completion
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Friendly snippets for luasnip (includes html ! expansion)
  { "rafamadriz/friendly-snippets" },

  -- obsidian integration
  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("obsidian").setup({
        dir = vim.fn.expand("~/Documents/blog/"),
        completion = { nvim_cmp = true },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("lualine").setup({ options = { theme = "auto" } }) end,
  },
  { "lewis6991/gitsigns.nvim", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "windwp/nvim-autopairs", config = true },
})

-- =============== Keymaps ===============
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true })
end, opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)
map("n", "<leader>od", "<cmd>ObsidianOpen<cr>", opts)
map("n", "<leader>on", "<cmd>ObsidianNew<cr>", opts)
map("n", "<leader>w","<cmd>write<cr>",opts)
map("n", "<leader>q","<cmd>exit<cr>",opts)
-- =============== Completion Setup ===============
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
})

-- Load friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Optional: Ctrl-k to expand or jump snippets
map("i", "<C-k>", function()
  if luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  end
end, { silent = true })

-- =============== LSP Setup ===============
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright", "ts_ls", "html", "cssls", "bashls", "lua_ls" },
  automatic_installation = true,
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "K", vim.lsp.buf.hover)
  bufmap("n", "<leader>rn", vim.lsp.buf.rename)
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action)
  bufmap("n", "gr", vim.lsp.buf.references)
  bufmap("n", "[d", vim.diagnostic.goto_prev)
  bufmap("n", "]d", vim.diagnostic.goto_next)
end

lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
})

-- =============== nvim-autopairs setup ===============
local npairs = require("nvim-autopairs")
npairs.setup({
  check_ts = true,
  ts_config = { html = { "tag", "attribute" } },
})

local Rule = require("nvim-autopairs.rule")
npairs.add_rules {
  Rule("<", ">"):with_pair(function(opts)
    local ts_conds = require("nvim-autopairs.ts-conds")
    return ts_conds.is_ts_node({ "tag" })(opts)
  end),
}

