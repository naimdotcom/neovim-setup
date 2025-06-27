-- lua/git-commit-ai/init.lua
local M = {}

-- Default configuration
local default_config = {
  max_diff_lines = 200,
  include_file_stats = true,
  auto_copy_to_clipboard = true,
  prompt_template = [[
Based on the following Git diff, generate a short, clear, and professional Git commit message using the conventional commits format (e.g., feat, fix, refactor, docs, style, chore).
Requirements:
1. Keep the main message under 200 characters.
2. Only include an optional body if the change is complex.
3. Avoid unnecessary details — focus on what changed and why.
4. Format: type(scope): short description
5. Output the result as: git commit -m "type(scope): description"
Git Diff:
%s
give me output in this format: Example Output:
git commit -m "generated commit message"
]],
  file_stats_template = "Files changed: %d, Insertions: %d, Deletions: %d"
}

local config = default_config

-- Setup function for user configuration
function M.setup(user_config)
  config = vim.tbl_deep_extend("force", default_config, user_config or {})
end

-- Utility function to execute shell commands
local function execute_command(cmd)
  local handle = io.popen(cmd)
  if not handle then
    return nil, "Failed to execute command"
  end

  local result = handle:read("*a")
  local success = handle:close()

  if not success then
    return nil, "Command execution failed"
  end

  return result:gsub("\n$", ""), nil -- Remove trailing newline
end

-- Check if we're in a git repository
local function is_git_repo()
  local _, err = execute_command("git rev-parse --git-dir 2>/dev/null")
  return err == nil
end

-- Get git diff for staged changes
local function get_staged_diff()
  return execute_command("git diff --cached")
end

-- Get git diff for all changes (staged + unstaged)
local function get_all_diff()
  return execute_command("git diff HEAD")
end

-- Get file statistics
local function get_file_stats()
  local stats, err = execute_command("git diff --cached --numstat")
  if err or not stats or stats == "" then
    return ""
  end

  local files_changed = 0
  local insertions = 0
  local deletions = 0

  for line in stats:gmatch("[^\r\n]+") do
    files_changed = files_changed + 1
    local added, removed = line:match("(%d+)%s+(%d+)")
    if added and removed then
      insertions = insertions + tonumber(added)
      deletions = deletions + tonumber(removed)
    end
  end

  if files_changed == 0 then
    return ""
  end

  return string.format(config.file_stats_template, files_changed, insertions, deletions)
end

-- Truncate diff if too long
local function truncate_diff(diff)
  local lines = {}
  local line_count = 0

  for line in diff:gmatch("[^\r\n]+") do
    line_count = line_count + 1
    if line_count > config.max_diff_lines then
      table.insert(lines, "... (diff truncated, showing first " .. config.max_diff_lines .. " lines)")
      break
    end
    table.insert(lines, line)
  end

  return table.concat(lines, "\n")
end

-- Copy text to clipboard
local function copy_to_clipboard(text)
  if not config.auto_copy_to_clipboard then
    return
  end

  -- Try different clipboard commands
  local clipboard_cmds = {
    "pbcopy",                     -- macOS
    "xclip -selection clipboard", -- Linux
    "wl-copy",                    -- Wayland
    "clip"                        -- Windows
  }

  for _, cmd in ipairs(clipboard_cmds) do
    local test_cmd = cmd:gsub("^(%S+).*", "%1")
    if execute_command("which " .. test_cmd .. " 2>/dev/null") then
      local handle = io.popen(cmd, "w")
      if handle then
        handle:write(text)
        handle:close()
        return true
      end
    end
  end

  return false
end

-- Main function to generate AI prompt
local function generate_commit_prompt(use_all_changes)
  -- Check if in git repo
  if not is_git_repo() then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  -- Get diff
  local diff, err
  if use_all_changes then
    diff, err = get_all_diff()
  else
    diff, err = get_staged_diff()
  end

  if err then
    vim.notify("Failed to get git diff: " .. err, vim.log.levels.ERROR)
    return
  end

  if not diff or diff == "" then
    local msg = use_all_changes and "No changes found" or "No staged changes found. Use :GitCommitAIAll for all changes"
    vim.notify(msg, vim.log.levels.WARN)
    return
  end

  -- Truncate diff if too long
  diff = truncate_diff(diff)

  -- Get file stats
  local file_stats = ""
  if config.include_file_stats then
    file_stats = get_file_stats()
  end

  -- Generate prompt
  local prompt = string.format(config.prompt_template, diff, file_stats)

  -- Create a new scratch buffer with the prompt
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(prompt, "\n"))
  vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
  vim.api.nvim_buf_set_name(buf, 'Git Commit AI Prompt')

  -- Open buffer in a new window
  vim.cmd('split')
  vim.api.nvim_win_set_buf(0, buf)

  -- Copy to clipboard
  local copied = copy_to_clipboard(prompt)

  -- Notify user
  local notify_msg = "Git commit AI prompt generated"
  if copied then
    notify_msg = notify_msg .. " and copied to clipboard"
  end
  vim.notify(notify_msg, vim.log.levels.INFO)
end

-- Command functions
function M.generate_staged()
  generate_commit_prompt(false)
end

function M.generate_all()
  generate_commit_prompt(true)
end

-- Setup commands
function M.setup_commands()
  vim.api.nvim_create_user_command('GitCommitAI', function()
    M.generate_staged()
  end, { desc = 'Generate AI prompt for staged git changes' })

  vim.api.nvim_create_user_command('GitCommitAIAll', function()
    M.generate_all()
  end, { desc = 'Generate AI prompt for all git changes' })
end

-- Auto-setup commands when plugin loads
M.setup_commands()

return M
