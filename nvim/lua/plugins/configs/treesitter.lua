return {
  ensure_installed = {
    "go",
    "gotmpl",
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
    "just",
    "groovy",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<A-v>",
      node_incremental = "v",
      scope_incremental = false,
      node_decremental = "V",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
        ["]a"] = "@parameter.inner",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]C"] = "@class.outer",
        ["]A"] = "@parameter.inner",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
        ["[a"] = "@parameter.inner",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[C"] = "@class.outer",
        ["[A"] = "@parameter.inner",
        ["[B"] = "@block.outer",
      },
    },
  },
}
