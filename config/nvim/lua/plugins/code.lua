-- Plugins that are related to coding. Such as lsp
-- or language specific.
return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function() require("plugins.configs.lspconfig") end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function() return require("plugins.configs.mason") end,
    config = function(_, opts)
      require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed then vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " ")) end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    keys = function()
      local move = require("nvim-treesitter-textobjects.move")
      local select = require("nvim-treesitter-textobjects.select")
      local swap = require("nvim-treesitter-textobjects.swap")
      local mode = { "n", "x", "o" }
      -- stylua: ignore
      return {
        { "]f", mode = mode, function() move.goto_next_start("@function.outer") end, desc = "Next Function Start" },
        { "]F", mode = mode, function() move.goto_next_end("@function.outer") end, desc = "Next Function, End" },
        { "[f", mode = mode, function() move.goto_previous_start("@function.outer") end, desc = "Previous Function Start" },
        { "[F", mode = mode, function() move.goto_previous_end("@function.outer") end, desc = "Previous Function End" },
        { "]c", mode = mode, function() move.goto_next_start("@class.outer") end, desc = "Next Class Start" },
        { "]C", mode = mode, function() move.goto_next_end("@class.outer") end, desc = "Next Class End" },
        { "]b", mode = mode, function() move.goto_next_start("@block.outer") end, desc = "Next Block Start" },
        { "]B", mode = mode, function() move.goto_next_end("@block.outer") end, desc = "Next Block End" },
        { "[c", mode = mode, function() move.goto_previous_start("@class.outer") end, desc = "Previous Class Start" },
        { "[C", mode = mode, function() move.goto_previous_end("@class.outer") end, desc = "Previous Class End" },
        { "]a", mode = mode, function() move.goto_next_start("@parameter.inner") end, desc = "Next Parameter Start" },
        { "]A", mode = mode, function() move.goto_next_end("@parameter.inner") end, desc = "Next Parameter End" },
        { "[a", mode = mode, function() move.goto_previous_start("@parameter.inner") end, desc = "Previous Parameter Start" },
        { "[A", mode = mode, function() move.goto_previous_end("@parameter.inner") end, desc = "Previous Parameter End" },
        { "[b", mode = mode, function() move.goto_previous_start("@block.outer") end, desc = "Previous Block Start" },
        { "[B", mode = mode, function() move.goto_previous_end("@block.outer") end, desc = "Previous Block End" },
        { "af", mode = mode, function() select.select_textobject("@function.outer") end, desc = "Select Function" },
        { "if", mode = mode, function() select.select_textobject("@function.inner") end, desc = "Select Inner Function" },
        { "ac", mode = mode, function() select.select_textobject("@class.outer") end, desc = "Select Class" },
        { "ic", mode = mode, function() select.select_textobject("@class.inner") end, desc = "Select Inner Class" },
        { "ab", mode = mode, function() select.select_textobject("@block.outer") end, desc = "Select Block" },
        { "ib", mode = mode, function() select.select_textobject("@block.inner") end, desc = "Select Inner Block" },
        { "ia", mode = mode, function() select.select_textobject("@parameter.inner") end, desc = "Select Inner Parameter" },
        { "<leader>a", mode = mode, function() swap.swap_next("@parameter.inner") end, desc = "Swap Next" },
        { "<leader>A", mode = mode, function() swap.swap_previous("@parameter.outer") end, desc = "Swap Next" },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    opts = { fast_wrap = {}, disable_filetype = { "snacks_picker_input", "vim" } },
  },
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "*",
    dependencies = {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      -- lazy = true,
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function(_, opts)
        require("luasnip").setup(opts)
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
      end,
    },
    opts = function() return require("plugins.configs.blink") end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function() return require("plugins.configs.conform") end,
    init = function() vim.g.autoformat = true end,
  },
  {
    "mfussenegger/nvim-lint",
    config = require("plugins.configs.lint"),
  },
  {
    "synic/refactorex.nvim",
    ft = "elixir",
    opts = {
      auto_update = true,
      pin_version = nil,
    },
  },
}
