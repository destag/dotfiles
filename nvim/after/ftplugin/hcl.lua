vim.bo.commentstring = "# %s"

vim.api.nvim_create_user_command("RunWorkflow", function(opts)
  local valid_commands = { apply = true, plan = true, output = true }
  if not valid_commands[opts.args] then
    vim.notify("Invalid command. Allowed values are: apply, plan, output", vim.log.levels.ERROR)
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
  complete = function() return { "plan", "apply", "output" } end,
})
