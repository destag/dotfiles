local blink_cmp = require("blink.cmp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = blink_cmp.get_lsp_capabilities(capabilities)

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
          disable = { "different-requires" },
        },
        workspace = {
          library = { os.getenv("HOME") .. "/.local/share/LuaAddons" },
        },
      },
    },
  },
  gopls = {
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
  },
  -- pyrefly = {},
  ty = {},
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
  -- expert = {},
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
  rust_analyzer = {},
}

for lsp, opts in pairs(servers) do
  opts.capabilities = capabilities
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
