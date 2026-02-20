return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    opts = {
      style = "night",
      on_highlights = function(hl, c)
        hl["FlashLabel"] = { fg = c.magenta2, bold = true }
        hl["@string.documentation"] = { link = "Comment" }
        hl["@lsp.mod.documentation"] = { link = "Comment" }
        hl["@property.toml"] = { fg = c.blue }
        hl["@property.yaml"] = { fg = c.blue }
        hl["@property.json"] = { fg = c.blue }
        hl["NeogitDiffAddHighlight"] = { link = "NeogitDiffAdd" }
        hl["NeogitDiffDeleteHighlight"] = { link = "NeogitDiffDelete" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
