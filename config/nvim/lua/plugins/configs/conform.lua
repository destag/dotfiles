return {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    python = { "ruff_organize_imports", "ruff_format" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "djlint" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    hcl = { "terragrunt_hclfmt" },
    sql = { "sqruff" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-sr", "-s", "-ci" },
    },
    sqruff = {
      args = {
        "fix",
        "--dialect=postgres",
        "$FILENAME",
      },
    },
  },
  format_on_save = function()
    if not vim.g.autoformat then return end
    return { timeout_ms = 10000, lsp_fallback = true }
  end,
}
