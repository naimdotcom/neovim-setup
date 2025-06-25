return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        -- Formatters
        null_ls.builtins.formatting.prettier,  -- for JS, TS, React, etc

        -- You can add more:
        null_ls.builtins.formatting.stylua,  -- Lua
        -- null_ls.builtins.formatting.black,   -- Python
        -- Diagnostics (optional)
        -- null_ls.builtins.diagnostics.eslint, 
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          -- Format keymap
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = false })
          end, { buffer = bufnr, desc = "Format file" })

          -- Auto format on save (optional, enable if you want)
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
