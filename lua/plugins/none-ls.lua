return {
 "nvimtools/none-ls.nvim",
 dependencies = { "nvim-lua/plenary.nvim" },
 config = function()
  local null_ls = require("null-ls")

  null_ls.setup({
   sources = {
    null_ls.builtins.formatting.prettier.with({
     extra_args = { "--tab-width", "3" },
    }),
    null_ls.builtins.formatting.stylua.with({
     extra_args = { "--tab-width", "3" },
    }), -- Lua
   },

   on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
     vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = false })
     end, { buffer = bufnr, desc = "Format file" })
     vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
       vim.lsp.buf.format({ async = false })
      end,
     })
    end
   end,
  })
 end,
}
