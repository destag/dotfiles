vim.bo.commentstring = "# %s"

vim.keymap.set("n", "<leader>uc", function()
  local content = vim.fn.getreg("*")
  vim.api.nvim_put({ "# checkov:skip=" .. content }, "l", true, true)
end, { desc = "Insert checkov skip line with register content" })

vim.keymap.set("n", "gx", function()
  local line = vim.api.nvim_get_current_line()
  local base = "https://registry.terraform.io/providers/hashicorp/%s/latest/docs/%s/%s"
  local block

  local provider, type_name = line:match('data%s+"([^_]+)_(.-)"%s+"')
  if provider and type_name then
    block = "data-sources"
  else
    provider, type_name = line:match('resource%s+"([^_]+)_(.-)"%s+"')
    if provider and type_name then block = "resource" end
  end

  local url = string.format(base, provider, block, type_name)

  if block then
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  else
    local file = vim.fn.expand("<cfile>")
    if file and file ~= "" then vim.ui.open(file) end
  end
end, { buffer = true, desc = "Open Terraform docs" })
