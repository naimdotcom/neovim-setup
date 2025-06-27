return {
  dir = "~/.config/nvim/lua/git-commit-ai",
  name = "git-commit-ai",
  config = function()
    require('git-commit-ai').setup({
      -- your configuration here
    })
  end
}
