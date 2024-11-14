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
  templ = {},
  ansiblels = {
    filetypes = { "yaml", "yml", "ansible" },
    root_dir = lspconfig.util.root_pattern("roles", "playbooks", "ansible.cfg"),
  },
  intelephense = {},
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
    local function bufopts(desc)
      desc = desc or ""
      return { noremap = true, silent = true, buffer = event.bufnr, desc = desc }
    end
    vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, bufopts("Next diagnostic"))
    vim.keymap.set("n", "]g", vim.diagnostic.goto_next, bufopts("Prev diagnostic"))
    vim.keymap.set("n", "<leader>dd", vim.diagnostic.setqflist, bufopts("Set diagnostic list"))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts("Go to declaration"))
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts("Go to definition"))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts("Go to implementation"))
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts("Go to type definition"))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts("Go to references"))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts("Code action"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("Rename"))
    vim.keymap.set("n", "L", vim.lsp.buf.hover, bufopts("Show hover"))
    vim.keymap.set("n", "<leader>fr", function()
      require("telescope.builtin").lsp_references()
    end, bufopts("Find references"))
    vim.keymap.set("n", "<leader>fs", function()
      require("telescope.builtin").lsp_document_symbols()
    end, bufopts("Find document symbols"))
    vim.keymap.set("n", "<leader>fS", function()
      require("telescope.builtin").lsp_workspace_symbols()
    end, bufopts("Find workspace symbols"))
  end,
})
