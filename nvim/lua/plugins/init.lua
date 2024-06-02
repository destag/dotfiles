return {
  { "folke/lazy.nvim", version = "*" },
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      {
        "-",
        '<cmd>lua require("oil").open_float()<CR>',
        desc = "Open parent directory",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- config = function(_, opts)
    --   require("oil").setup(opts)
    --   vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    -- end,
  },
}
