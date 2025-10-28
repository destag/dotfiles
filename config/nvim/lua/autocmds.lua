local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value
    if not client or type(value) ~= "table" then return end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {}
    progress[client.id] = vim.tbl_filter(function(v) return table.insert(msg, v.msg) or not v.done end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

local config = require("plugins.configs.treesitter")

local function highlight_enabled(lang)
  local lang_config = config[lang] or { highlight = true }
  return lang_config.highlight
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    local ts = require("nvim-treesitter")

    local ft = vim.bo[event.buf].ft
    local lang = vim.treesitter.language.get_lang(ft)

    if vim.list_contains(ts.get_installed({ type = "parser" }), lang) then
      if highlight_enabled(ft) then vim.treesitter.start(event.buf, lang) end
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    else
      if not vim.list_contains(ts.get_available(), lang) then return end

      ts.install({ lang }):await(function(err)
        if err then
          vim.notify("Treesitter install error for lang: " .. lang .. " err: " .. err)
          return
        end
      end)
    end
  end,
})
