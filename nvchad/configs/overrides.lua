local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "python",
    "markdown",
    "markdown_inline",
    "go",
    "templ",
    "terraform",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- go stuff
    "gopls",
    "gofumpt",
    "goimports-reviser",
    "golangci-lint",
    "gomodifytags",
    "gotests",
    "iferr",
    "impl",
    "templ",

    -- python stuff
    "black",
    "mypy",
    "ruff",
    "pyright",

    -- terraform stuff
    "terraform-ls",
    "tflint",

    -- shell stuff
    "shfmt",
    "shellcheck",

    -- markdown stuff
    "marksman",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
