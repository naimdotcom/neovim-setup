return {
 "akinsho/bufferline.nvim",
 version = "*",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 config = function()
  require("bufferline").setup({
   options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    offsets = {
     {
      filetype = "neo-tree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left",
     }
    }
   }
  })
  vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
  vim.keymap.set("n", "<S-h>", ":bprev<CR>", { silent = true })
 end,
}
