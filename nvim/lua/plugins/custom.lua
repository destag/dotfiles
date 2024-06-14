local plugins = {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-a>", function()
        require("neocodeium").accept()
      end)
      vim.keymap.set("i", "<A-w>", function()
        require("neocodeium").accept_word()
      end)
      vim.keymap.set("i", "<A-l>", function()
        require("neocodeium").accept_line()
      end)
      vim.keymap.set("i", "<A-n>", function()
        require("neocodeium").cycle_or_complete()
      end)
      vim.keymap.set("i", "<A-m>", function()
        require("neocodeium").cycle_or_complete(-1)
      end)
      vim.keymap.set("i", "<A-c>", function()
        require("neocodeium").clear()
      end)
      vim.keymap.set("i", "<A-s>", function()
        require("neocodeium").show()
      end)
    end,
  },
}
return plugins
