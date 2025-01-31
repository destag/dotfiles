-- File is used for any editing based plugins
-- Contains vim-sleuth, which is used for automatic identations
-- trim.nvim which is used for automatically trimming whitespace
return {
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
  },
  {
    "cappyzawa/trim.nvim",
    event = "VeryLazy",
    opts = {
      ft_blocklist = { "markdown" },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      label = {
        uppercase = false,
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      throttle = true,
      max_lines = 5,
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
    },
    keys = {
      {
        "gC",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        desc = "Previous context",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Harpoon",
    opts = {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    keys = {
      { "<leader>hh", function() require("harpoon"):list():add() end, desc = "Harpoon File" },
      { "<C-n>", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end, desc = "Next Location" },
      { "<C-p>", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end, desc = "Previous Location" },
      { "<Leader>rh", function() require("harpoon"):list():remove() end, desc = "Remove Location" },
      { "<A-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1" },
      { "<A-j>", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2" },
      { "<A-k>", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3" },
      { "<A-l>", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4" },
      {
        "<leader>H",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "List locations",
      },
    },
  },
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Toggle Split/Join" },
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
