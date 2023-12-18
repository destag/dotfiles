---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>gB"] = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blame" },
    ["<leader>tt"] = { "<cmd>Telescope diagnostics<CR>", "Open telescope diagnostics" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

return M
