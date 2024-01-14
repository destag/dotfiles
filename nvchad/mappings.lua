---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>gB"] = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle git blame" },
    ["<leader>tt"] = { "<cmd>Telescope diagnostics<CR>", "Open telescope diagnostics" },

    -- tmux navigator
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<CR>", "Window left" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<CR>", "Window right" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<CR>", "Window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<CR>", "Window up" },

    -- golang
    ["<leader>gie"] = { "<cmd>GoIfErr<CR>", "Add if err != nil" },
    ["<leader>gis"] = { "<cmd>GoFillStruct<CR>", "Fill go struct" },

    -- neogit
    ["<leader>gg"] = { "<cmd>Neogit<CR>", "Open neogit" },

    -- symbols-outline
    ["<leader>cs"] = { "<cmd>SymbolsOutline<cr>", "Open symbols outline" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  x = {
    ["Q"] = { ":norm @q<CR>", "multiline macro" },
  },
}

-- more keybinds!

return M
