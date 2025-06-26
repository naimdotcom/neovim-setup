return {
 "akinsho/bufferline.nvim",
 version = "*",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 config = function()
  require("bufferline").setup({
   options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    separator_style = "slope",
    indicator = {
     style = "icon", -- disables the icon so underline highlight shows clearly
     icon = "▎",
    },
    offsets = {
     {
      filetype = "neo-tree",
      text = "File Explorer",
      highlight = "Directory",
      text_align = "left",
     }
    },
    hover = {
     enabled = true,
     delay = 200,
     reveal = { "close" },
    },
    max_name_length = 18,
    tab_size = 0,

    show_buffer_close_icons = true,
    show_close_icon = true,
    enforce_regular_tabs = false,
    show_duplicate_prefix = true,
   },
   highlights = {
    buffer_selected = {
     underline = true,
     bold = true,
     italic = false,
    },
   },
  })
  -- Keymaps for switching buffers
  vim.keymap.set("n", "<S-l>", ":bnext<CR>", { silent = true })
  vim.keymap.set("n", "<S-h>", ":bprev<CR>", { silent = true })
 end,
}
-- STYLING
--bufferline-styling
--You can change the appearance of the bufferline separators by setting the
--separator_style. The available options are:
--* slant - Use slanted/triangular separators
--* padded_slant - Same as slant but with extra padding which some terminals require.
--If slant does not render correctly for you try padded this instead.
--* slope - Use slanted/triangular separators but slopped to the right
--* padded_slope - Same as slope but with extra padding which some terminals require.
--If slope does not render correctly for you try padded this instead.
--* thick - Increase the thickness of the separator characters
--* thin - (default) Use thin separator characters
--* finally you can pass in a custom list containing 2 characters which will be
--used as the separators e.g. {"I", "I"?, the first is the left and the
--second is the right separator
