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
    "numToStr/Comment.nvim",
    init = function()
      local wk = require("which-key")
      wk.add({
        "<leader>/",
        function() require("Comment.api").toggle.linewise.current() end,
        desc = "Toggle comment",
      })
      wk.add({
        "<leader>/",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        desc = "Toggle comment",
        mode = "v",
      })
    end,
    config = function(_, opts) require("Comment").setup(opts) end,
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
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    lazy = true,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    opts = { history = true, updateevents = "TextChanged,TextChangedI" },
    config = function(_, opts) require("plugins.configs.others").luasnip(opts) end,
  },
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "snacks_picker_input", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function() return require("plugins.configs.cmp") end,
    config = function(_, opts) require("cmp").setup(opts) end,
  },
  {
    "saghen/blink.cmp",
    enabled = true,
    version = "*",
    opts = function() return require("plugins.configs.blink") end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = function() return require("plugins.configs.conform") end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters.sqlfluff.args = {
        "lint",
        "--format=json",
        "--dialect=postgres",
      }

      lint.linters_by_ft = {
        elixir = { "credo" },
        python = { "ruff", "mypy" },
        terraform = { "tflint" },
        sql = { "sqlfluff" },
        sh = { "shellcheck" },
        php = { "phpstan" },
      }

      vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave" }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
      require("telescope").load_extension("refactoring")

      vim.keymap.set({ "n", "x" }, "<leader>rr", function() require("telescope").extensions.refactoring.refactors() end)
    end,
  },
}
