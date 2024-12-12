return {
  {
    "atiladefreitas/dooing",
    config = function()
      require("dooing").setup({
        keymaps = {
          toggle_window = "<leader>T",
        },
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
}
