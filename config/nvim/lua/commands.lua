vim.api.nvim_create_user_command("ToggleFormat", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify(string.format("%s formatting...", vim.g.autoformat and "Enabling" or "Disabling"), vim.log.levels.INFO)
end, { desc = "Toggle conform.nvim auto-formatting", nargs = 0 })

vim.api.nvim_create_user_command("CopyRelPath", function()
  local relative_path = vim.fn.expand("%:p:.")
  vim.fn.setreg("+", relative_path)
  print("Copied to clipboard: " .. relative_path)
end, { desc = "Copy the relative path of the current file to the clipboard", nargs = 0 })

vim.api.nvim_create_user_command(
  "Gcommit",
  function(opts) vim.cmd("!" .. 'git commit -m "' .. opts.args .. '"') end,
  { nargs = 1 }
)

vim.api.nvim_create_user_command("Gpush", function() vim.cmd("!git push") end, { nargs = 0 })
