return {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports-reviser", "golines" },
    python = { "ruff_organize_imports", "ruff_format" },
    css = { "biome" },
    html = { "djlint" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    hcl = { "terragrunt_hclfmt" },
    sql = { "sqruff" },
    json = { "biome" },
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
    return { timeout_ms = 1000, lsp_fallback = true }
  end,
}
