local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
          disable = { "different-requires" },
        },
      },
    },
  },
  rust_analyzer = {
    cargo = {
      features = { "all" },
    },
  },
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
  },
  pyright = {},
  terraformls = {},
  elixirls = {
    cmd = { "elixir-ls" },
  },
  bashls = {},
  -- lexical = {
  --   cmd = { "lexical" },
  -- },
}

for lsp, opts in pairs(servers) do
  lspconfig[lsp].setup(opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local bufopts = { noremap = true, silent = true, buffer = event.bufnr }
    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set("n", "]g", vim.diagnostic.goto_next, bufopts)
    vim.keymap.set("n", "<leader>dd", vim.diagnostic.setqflist, bufopts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "L", vim.lsp.buf.hover, bufopts)
  end,
})
