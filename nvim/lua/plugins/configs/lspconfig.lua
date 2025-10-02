local navic = require("nvim-navic")

local blink_cmp = require("blink.cmp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = blink_cmp.get_lsp_capabilities(capabilities)

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then navic.attach(client, bufnr) end
end

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
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
  },
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
        },
      },
    },
  },
  terraformls = {},
  elixirls = {
    cmd = { "elixir-ls" },
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      elixirLS = {
        dialyzerEnabled = false,
        enableTestLenses = false,
      },
    },
  },
  bashls = {},
  templ = {},
  ansiblels = {
    filetypes = { "yaml.ansible" },
    root_markers = { "roles", "playbooks", "ansible.cfg" },
  },
  phpactor = {},
  tailwindcss = {
    filetypes = { "html" },
  },
  regols = {},
}

for lsp, opts in pairs(servers) do
  opts.capabilities = capabilities
  opts.on_attach = on_attach
  vim.lsp.config(lsp, opts)
  vim.lsp.enable(lsp)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local function bufopts(desc)
      desc = desc or ""
      return { noremap = true, silent = true, buffer = event.bufnr, desc = desc }
    end
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts("Code action"))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("Rename"))
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Show hover"))
  end,
})
