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
      modes = {
        char = {
          jump_labels = true,
          keys = { "f", "F", "t", "T", [";"] = "L", [","] = "H" },
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter({
            actions = {
              ["."] = "next",
              [","] = "prev",
            },
          })
        end,
        desc = "Flash Treesitter",
      },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "cbochs/grapple.nvim",
    dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
    opts = { scope = "git_branch" },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
      { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
      { "<C-n>", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
      { "<C-p>", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
      { "<A-h>", "<cmd>Grapple select index=1<cr>", desc = "Grapple to tag 1" },
      { "<A-j>", "<cmd>Grapple select index=2<cr>", desc = "Grapple to tag 2" },
      { "<A-k>", "<cmd>Grapple select index=3<cr>", desc = "Grapple to tag 3" },
      { "<A-l>", "<cmd>Grapple select index=4<cr>", desc = "Grapple to tag 4" },
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
  {
    "MagicDuck/grug-far.nvim",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      { "kevinhwang91/promise-async" },
    },
    keys = {
      { "zc", mode = "n", desc = "Fold current line" },
      { "zo", mode = "n", desc = "Unfold current line" },
      { "za", mode = "n", desc = "Toggle fold current line" },
      { "zA", mode = "n", desc = "Toggle fold all lines" },
      { "zr", mode = "n", desc = "Unfold all lines" },
      { "zR", mode = "n", desc = "Fold all lines" },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype) return { "treesitter", "indent" } end,
    },
  },
}
