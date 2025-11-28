-- local days = function()
--   local start_date = os.time({ year = 2023, month = 11, day = 28 })
--   local current_date = os.time()
--   local diff = os.difftime(current_date, start_date)
--   return math.floor(diff / (24 * 60 * 60))
-- end
--
-- local days_since = days() .. " \n\n"

local header = [[
 ╭───┬───┬───┬───┬───┬───┬───┬───┬───┬───╮
  │ Q │ W │ E │ R │ T │ Y │ U │ I │ O │ P │
  ╰┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴╮
   │ A │ S │ D │ F │ G │ ← │ ↓ │ ↑ │ → │ ; │
   ╰┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──╯
  │ Z │ X │ C │  │ B │  │ M │ < │ > │
 ╰───┴───┴───┴───┴───┴───┴───┴───┴───╯

[ TIP: To exit Neovim, just power off your computer. ]
]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    -- words
    { "]]", function() require("snacks").words.jump(1, true) end, desc = "Next reference" },
    { "[[", function() require("snacks").words.jump(-1, true) end, desc = "Prev reference" },
    -- pickers
    { "<leader>S", function() require("snacks").picker.resume() end },
    { "<leader>;", function() require("snacks").picker.lines() end, desc = "Find Line" },
    { "<leader>,", function() require("snacks").picker.buffers() end, desc = "Find Buffer" },
    { "<leader>/", function() require("snacks").picker.grep() end, desc = "Find with Grep" },
    {
      "<leader>sg",
      function() require("snacks").picker.grep({ dirs = { vim.fn.expand("%:p:h") } }) end,
      desc = "Find with Grep in Current Directory",
    },
    {
      "<leader><space>",
      function() require("snacks").picker.files({ formatters = { file = { truncate = 80 } } }) end,
      desc = "Find File",
    },
    {
      "<leader>.",
      function() require("snacks").picker.recent({ filter = { cwd = true } }) end,
      desc = "Find Old Files",
    },
    { "<leader>sc", function() require("snacks").picker.command_history() end, desc = "Command History" },
    { "<leader>sC", function() require("snacks").picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sk", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
    { "<leader>su", function() require("snacks").picker.undo() end, desc = "Undo Tree" },
    { "<leader>sf", function() require("snacks").picker.explorer() end, desc = "File Explorer" },
    { "<leader>sb", function() require("snacks").picker.grep_buffers() end, desc = "Grep Buffers" },
    {
      "<leader>sq",
      function() require("snacks").picker.qflist() end,
      desc = "Quickfix List",
    },
    {
      "<leader>sm",
      function()
        vim.cmd("MarksListAll")
        vim.cmd("lcl")
        require("snacks").picker.loclist()
      end,
      desc = "Find Mark",
    },
    {
      "<leader>sw",
      function() require("snacks").picker.grep_word() end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- LSP
    {
      "<leader>ss",
      function() require("snacks").picker.lsp_symbols({ filter = { default = true } }) end,
      desc = "LSP Symbols",
    },
    { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Go to Definition" },
    { "gr", function() require("snacks").picker.lsp_references() end, nowait = true, desc = "Find References" },
    -- git
    { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gl", function() require("snacks").picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs", function() require("snacks").picker.git_status() end, desc = "Git Status" },
    { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff (Hunks)" },
    {
      "<leader>gy",
      function()
        require("snacks").gitbrowse.open({
          open = function(url)
            vim.fn.setreg("+", url)
            vim.notify("Yanked url to clipboard")
          end,
          notify = false,
          what = "permalink",
        })
      end,
      desc = "Copy line(s) link",
      mode = { "n", "v" },
    },
    -- github
    { "<leader>gi", function() require("snacks").picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI", function() require("snacks").picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp", function() require("snacks").picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    {
      "<leader>gP",
      function() require("snacks").picker.gh_pr({ state = "all" }) end,
      desc = "GitHub Pull Requests (all)",
    },
    -- notifications
    { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
    -- scratch
    { "<leader>z", function() require("snacks").scratch({ ft = "markdown" }) end, desc = "Toggle Scratch Buffer" },
    { "<leader>Z", function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
    -- terminal
    { "<c-t>", function() require("snacks").terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle Terminal" },
  },
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
      },
      preset = {
        header = header,
      },
    },
    indent = {
      enabled = true,
      only_scope = false,
      only_current = true,
      indent = {
        enabled = false,
      },
      animate = { enabled = false },
    },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    picker = { enabled = true, previewers = { git = { builtin = true } } },
    scope = { enabled = true },
    explorer = { replace_netrw = true },
    zen = { win = { backdrop = { transparent = false } } },
  },
}
