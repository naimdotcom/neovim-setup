return {
  dir = "~/.config/nvim/lua/git-commit-ai", -- absolute path to your plugin folder
  name = "git-commit-ai",
  config = function()
    require('git-commit-ai').setup({
      -- your configuration here
    })

    vim.keymap.set('n', '<leader>gca', ':GitCommitAI<CR>', { desc = 'Git Commit AI (staged)' })
    vim.keymap.set('n', '<leader>gcA', ':GitCommitAIAll<CR>', { desc = 'Git Commit AI (all)' })
  end
}
