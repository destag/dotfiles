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
    sql = { "sqlfluff" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-sr", "-s", "-ci" },
    },
    sqlfluff = {
      command = "sqlfluff",
      args = {
        "fix",
        "--dialect",
        "postgres",
        "--disable-progress-bar",
        "--quiet",
        "-",
      },
      require_cwd = false,
    },
  },
  format_on_save = function()
    if not vim.g.autoformat then return end
    return { timeout_ms = 10000, lsp_fallback = true }
  end,
}
