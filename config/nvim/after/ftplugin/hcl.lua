vim.bo.commentstring = "# %s"

vim.api.nvim_create_user_command("RunWorkflow", function(opts)
  local valid_commands = { apply = true, plan = true, output = true, destroy = true }
  if not valid_commands[opts.args] then
    vim.notify("Invalid command. Allowed values are: apply, plan, output, destroy", vim.log.levels.ERROR)
    return
  end

  local branch = vim.fn.system("git branch --show-current")
  branch = branch:gsub("\n", "")
  if branch ~= "main" then
    vim.notify("You must be on the main branch to run workflows", vim.log.levels.ERROR)
    return
  end

  local file_path = vim.fn.expand("%:p:.")
  local dir_path = vim.fn.fnamemodify(file_path, ":h")

  local gh_command =
    string.format("gh workflow run workflow_dispatch.yaml -f command=%s -f path=%s/", opts.args, dir_path)

  local result = vim.fn.system(gh_command)

  if vim.v.shell_error == 0 then
    vim.notify("Workflow triggered successfully for path: " .. dir_path, vim.log.levels.INFO)
  else
    vim.notify("Failed to trigger workflow: " .. result, vim.log.levels.ERROR)
  end
end, {
  nargs = 1,
  desc = "Run a GitHub workflow with the current buffer path",
  complete = function() return { "plan", "apply", "output", "destroy" } end,
})

vim.api.nvim_create_user_command("UpdateTrigger", function()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  ---@diagnostic disable-next-line: param-type-mismatch
  local timestamp = os.date("%Y-%m-%d %H:%M:%S%z"):gsub("([+-]%d%d)(%d%d)", "%1:%2")
  local trigger_line = "# trigger " .. timestamp

  if #lines > 0 and lines[#lines]:match("^# trigger") then
    lines[#lines] = trigger_line
  else
    table.insert(lines, trigger_line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end, {})
