local blink_cmp = require("blink.cmp")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = blink_cmp.get_lsp_capabilities(capabilities)

local function tinygo_env(root)
  if not root then return {} end

  local path = root .. "/.tinygo"
  if vim.fn.filereadable(path) ~= 1 then return {} end

  local target = vim.fn.readfile(path)[1]
  if not target then return {} end

  local output = vim.fn.system({ "tinygo", "info", "-json", target })
  if vim.v.shell_error ~= 0 then error("Failed to get TinyGo environment: " .. output) end

  local info = vim.json.decode(output)
  return {
    GOROOT = info.goroot,
    GOFLAGS = "-tags=" .. table.concat(info.build_tags, ","),
  }
end

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
    cmd = function(dispatchers, config)
      local root = config.root_dir
      return vim.lsp.rpc.start({ "gopls" }, dispatchers, {
        cwd = root,
        env = tinygo_env(root),
      })
    end,
  },
  biome = {},
  ty = {},
  terraformls = {},
  expert = {},
  shuck = {},
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

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    client.server_capabilities.codeLensProvider = nil
  end,
})
