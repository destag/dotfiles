return {
  ensure_installed = {
    "go",
    "lua",
    "python",
    "terraform",
    "hcl",
    "elixir",
    "eex",
    "heex",
    "templ",
    "php",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-k>",
      node_incremental = "<A-k>",
      scope_incremental = false,
      node_decremental = "<A-j>",
    },
  },
}
