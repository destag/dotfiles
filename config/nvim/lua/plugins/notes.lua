return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = { "Obsidian" },
  keys = {
    { "<leader>nn", mode = "n", "<cmd>Obsidian new<cr>", desc = "New Note" },
    { "<leader>ng", mode = "n", "<cmd>Obsidian search<cr>", desc = "Grep" },
    { "<leader>ns", mode = "n", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
    { "<leader>nt", mode = "n", "<cmd>Obsidian tags<cr>", desc = "Tags" },
    { "<leader>nd", mode = "n", "<cmd>Obsidian dailies<cr>", desc = "Daily Notes" },
    { "<leader>nb", mode = "n", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
  },
  opts = {
    legacy_commands = false, -- this will be removed in the next major release
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian",
      },
    },
    daily_notes = { folder = "daily" },
    statusline = { enabled = false },
    ui = { enable = false },
    note_id_func = function(title)
      if title == nil then return require("obsidian.builtin").zettle_id end
      return title
    end,
  },
}
