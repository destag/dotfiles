return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c) hl["FlashLabel"] = { fg = c.magenta2, bold = true } end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}
