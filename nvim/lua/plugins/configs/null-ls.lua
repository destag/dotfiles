local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

return {
  sources = {
    -- golang
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.diagnostics.staticcheck,

    -- lua
    null_ls.builtins.formatting.stylua,

    -- python
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.diagnostics.mypy,
    -- null_ls.builtins.diagnostics.ruff,

    -- elixir
    null_ls.builtins.diagnostics.credo,

    -- terraform
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.diagnostics.terraform_validate,

    -- bash
    null_ls.builtins.formatting.shfmt.with({ extra_args = { "-i", "2", "-sr", "-s", "-ci" } }),
    -- null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),

    -- sql
    null_ls.builtins.diagnostics.sqlfluff.with({
      extra_args = { "--dialect", "postgres" },
    }),
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
}
