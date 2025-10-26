vim.keymap.set("n", "<TAB>", "<cmd>bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bp<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>bdelete<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

vim.keymap.set("n", "<leader>uf", "<cmd>ToggleFormat<cr>", { desc = "Toggle Formatting" })
vim.keymap.set("n", "<leader>um", "<cmd>NeoCodeium toggle<cr>", { desc = "Toggle Formatting" })

-- Close floathing windows with escape
vim.keymap.set("n", "<esc>", function()
  local found_float = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" and config.zindex ~= 20 then
      vim.api.nvim_win_close(win, true)
      found_float = true
    end
  end

  if found_float then return end

  vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
end, { desc = "Toggle Diagnostics" })

vim.keymap.set("n", "<leader>ur", function()
  ---@diagnostic disable-next-line: undefined-field
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle relative line numbers" })
