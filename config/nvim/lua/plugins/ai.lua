return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      silent = true,
      filter = function(bufnr)
        local filetype = vim.bo[bufnr].filetype
        return not vim.tbl_contains({ "snacks_picker_input", "env" }, filetype)
      end,
    },
    keys = {
      { "<A-a>", mode = "i", function() require("neocodeium").accept() end },
      { "<A-w>", mode = "i", function() require("neocodeium").accept_word() end },
      { "<A-l>", mode = "i", function() require("neocodeium").accept_line() end },
      { "<A-n>", mode = "i", function() require("neocodeium").cycle_or_complete() end },
      { "<A-m>", mode = "i", function() require("neocodeium").cycle_or_complete(-1) end },
      { "<A-c>", mode = "i", function() require("neocodeium").clear() end },
      { "<A-s>", mode = "i", function() require("neocodeium").show() end },
    },
  },
}
