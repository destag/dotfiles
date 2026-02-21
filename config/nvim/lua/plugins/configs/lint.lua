return function()
  local lint = require("lint")

  lint.linters.sqruff.args = {
    "lint",
    "--format=json",
    "--dialect=postgres",
    "-",
  }

  lint.linters_by_ft = {
    elixir = { "credo" },
    python = { "ruff" },
    terraform = { "tflint" },
    sql = { "sqruff" },
    sh = { "shellcheck" },
  }

  vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave" }, {
    callback = function() lint.try_lint() end,
  })
end
