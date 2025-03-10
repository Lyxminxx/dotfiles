-- Adjust the path to Lazy based on where it's installed.
-- Make sure the correct path is included to load Lazy.
vim.cmd('set runtimepath+=C:/Users/MarkusTrygstadLyngvæ/AppData/Local/nvim/lazy/lazy.nvim') -- Adjust this path

require("lazy").setup({

  -- Install Dracula Theme
  { 'dracula/vim' },

  -- Telescope for file searching and more
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Telescope Fuzzy Native Extension for performance
  { 'nvim-telescope/telescope-fzy-native.nvim' },

  -- nvim-cmp for autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },

})

-- Set Dracula Theme
vim.cmd('colorscheme dracula')

-- Keybindings for Telescope
vim.api.nvim_set_keymap('n', '<Space>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- nvim-cmp Configuration for Autocompletion
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#expand"](args.body)
    end,
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.close(),
  },
  sources = {
    { name = 'buffer' },
  },
})

