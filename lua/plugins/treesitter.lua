return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({})

			vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal right<CR>")
			vim.api.nvim_create_autocmd("QuitPre", {
				callback = function()
					require("neo-tree.command").execute({ action = "close" })
				end,
			})
		end,
	},
}
