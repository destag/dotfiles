local options = {
  keymap = {
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = {
      "select_next",
      "snippet_forward",
      "fallback",
    },
    ["<S-Tab>"] = {
      "select_prev",
      "snippet_backward",
      "fallback",
    },
  },
  signature = { enabled = true },
  snippets = { preset = "luasnip" },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 50 },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    cmdline = {},
  },
}
return options
