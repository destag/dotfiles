vim.bo.commentstring = "# %s"

vim.keymap.set("n", "<leader>uc", function()
  local content = vim.fn.getreg("*")
  vim.api.nvim_put({ "# checkov:skip=" .. content }, "l", true, true)
end, { desc = "Insert checkov skip line with register content" })
