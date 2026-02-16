return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  ft = "markdown",
  cmd = { "Obsidian" },
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
