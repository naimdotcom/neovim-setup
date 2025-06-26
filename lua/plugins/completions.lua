return {
 {
  "L3MON4D3/LuaSnip",
  dependencies = {
   "saadparwaiz1/cmp_luasnip",
   "rafamadriz/friendly-snippets",
  },
 },
 {
  "hrsh7th/nvim-cmp",
  dependencies = {
   "hrsh7th/cmp-nvim-lsp",     -- LSP completion source
   "hrsh7th/cmp-buffer",       -- Buffer words
   "hrsh7th/cmp-path",         -- File paths
   "L3MON4D3/LuaSnip",         -- Snippets
   "saadparwaiz1/cmp_luasnip", -- Snippet completion
   "rafamadriz/friendly-snippets",
  },
  config = function()
   local cmp = require("cmp")
   require("luasnip.loaders.from_vscode").lazy_load()

   cmp.setup({
    snippet = {
     expand = function(args)
      require("luasnip").lsp_expand(args.body)
     end,
    },
    window = {
     completion = cmp.config.window.bordered(),
     documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
     ["<Tab>"] = cmp.mapping.select_next_item(),
     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
     ["<CR>"] = cmp.mapping.confirm({ select = true }),
     ["<C-Space>"] = cmp.mapping.complete(),
     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
     ["<C-f>"] = cmp.mapping.scroll_docs(4),
     ["<C-e>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
     { name = "nvim_lsp" },
     { name = "luasnip" },
     { name = "buffer" },
     { name = "path" },
    }),
   })
  end,
 },

 {
  "windwp/nvim-autopairs",
  event = "InsertEnter", -- Load when you start typing
  config = function()
   require("nvim-autopairs").setup({})
  end,
 },
}
