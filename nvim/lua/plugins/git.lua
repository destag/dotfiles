return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    config = true,
    opts = {
      graph_style = "kitty",
    },
  },
  {
    "sindrets/diffview.nvim",
    enabled = true,
    opts = {
      enhanced_diff_hl = false,
      view = {
        merge_tool = { layout = "diff3_mixed" },
      },
    },
  },
}
