return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    scss = { "prettier" },
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
  format_on_save = {
    timeout_ms = 10000,
    lsp_fallback = true,
  },
}
