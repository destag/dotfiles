-- Use this file for any colorschemes that you wish to install.
-- Comes with catppuccin by default.
return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
}
