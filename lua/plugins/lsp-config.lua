return {
 {
  "williamboman/mason.nvim",
  config = function()
   require("mason").setup()
  end,
 },
 {
  "williamboman/mason-lspconfig.nvim",
  config = function()
   require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls",
     "ts_ls",
     "pyright",
     "clangd",
    }
   })
  end,
 },
 {
  "neovim/nvim-lspconfig",
  config = function()
   local lspconfig = require("lspconfig")

   -- Common on_attach function
   local on_attach = function(_, bufnr)
    -- Keymaps for LSP actions
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
   end

   lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = {
     Lua = {
      diagnostics = {
       globals = { "vim" },
      },
     },
    },
   })
   -- TypeScript / JavaScript
   lspconfig.ts_ls.setup({
    on_attach = on_attach,
   })

   -- Python
   lspconfig.pyright.setup({
    on_attach = on_attach,
   })

   -- C / C++
   lspconfig.clangd.setup({
    on_attach = on_attach,
   })
  end,
 },
}
