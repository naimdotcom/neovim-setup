return {
 -- {
 --  "folke/tokyonight.nvim",
 --  lazy = false,
 --  priority = 1000,
 --  opts = {},
 --  config = function()
 --   vim.cmd("colorscheme tokyonight-night")
 --  end
 -- },
 {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
   --   vim.cmd.colorscheme("catppuccin-mocha")
  end
 },
 {
  "nyoom-engineering/oxocarbon.nvim",
  config = function()
   vim.opt.background = "dark" -- set this to dark or light
   vim.cmd("colorscheme oxocarbon")
  end
 }
}
