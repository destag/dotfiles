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
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = {
      "apple/pkl-neovim",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = function() return require("plugins.configs.treesitter") end,
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },
  {
    "windwp/nvim-autopairs",
    opts = {
      fast_wrap = {},
      disable_filetype = { "snacks_picker_input", "vim" },
    },
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
