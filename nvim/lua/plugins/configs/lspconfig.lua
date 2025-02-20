local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp") and require("cmp_nvim_lsp")
local blink_cmp = not cmp_nvim_lsp and pcall(require, "blink.cmp") and require("blink.cmp")

if cmp_nvim_lsp then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
elseif blink_cmp then
  capabilities = blink_cmp.get_lsp_capabilities(capabilities)
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
  -- nextls = {
  --   cmd = { "nextls", "--stdio" },
  --   init_options = {
  --     extensions = {
  --       credo = { enable = true },
  --     },
  --     experimental = {
  --       completions = { enable = true },
  --     },
  --   },
  -- },
  bashls = {},
  templ = {},
  ansiblels = {
    filetypes = { "yaml.ansible" },
    root_dir = lspconfig.util.root_pattern("roles", "playbooks", "ansible.cfg"),
  },
  phpactor = {},
  tailwindcss = {
    filetypes = { "html" },
  },
  regols = {},
}

for lsp, opts in pairs(servers) do
  opts.capabilities = capabilities
  lspconfig[lsp].setup(opts)
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
