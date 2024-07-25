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
    "ggandor/leap.nvim",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      throttle = true,
      max_lines = 0,
      patterns = {
        default = {
          "class",
          "function",
          "method",
        },
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Harpoon",
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Add Location",
      },
      {
        "<C-n>",
        function()
          require("harpoon"):list():next({ ui_nav_wrap = true })
        end,
        desc = "Next Location",
      },
      {
        "<C-p>",
        function()
          require("harpoon"):list():prev({ ui_nav_wrap = true })
        end,
        desc = "Previous Location",
      },
      {
        "<Leader>mr",
        function()
          require("harpoon"):list():remove()
        end,
        desc = "Remove Location",
      },
      {
        "<LocalLeader>1",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Harpoon to File 1",
      },
      {
        "<LocalLeader>2",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Harpoon to File 2",
      },
      {
        "<LocalLeader>3",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Harpoon to File 3",
      },
      {
        "<LocalLeader>4",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Harpoon to File 4",
      },
      {
        "<LocalLeader>5",
        function()
          require("harpoon"):list():select(5)
        end,
        desc = "Harpoon to File 5",
      },

      {
        "<LocalLeader>l",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "List locations",
      },
    },
  },
  {
    "letieu/harpoon-lualine",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
      },
    },
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    dependencies = "nvim-treesitter",
    config = function()
      require("illuminate").configure({
        under_cursor = true,
        max_file_lines = nil,
        delay = 100,
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        filetypes_denylist = {
          "NvimTree",
          "Trouble",
          "Outline",
          "TelescopePrompt",
          "Empty",
          "dirvish",
          "fugitive",
          "alpha",
          "packer",
          "neogitstatus",
          "spectre_panel",
          "toggleterm",
          "DressingSelect",
          "aerial",
        },
      })
    end,
  },
}
