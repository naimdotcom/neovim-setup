return {
 {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons",
   "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {},
  --  config = function()
  --   require("neo-tree").setup({
  --    window = {
  --     position = "right"
  --    }
  --   })
  --   vim.api.nvim_create_autocmd("VimEnter", {
  --    callback = function()
  --     if vim.fn.argv(0) == "" then
  --      vim.cmd("Neotree show")
  --     end
  --    end,
  --   })
  --  end
 },
}
