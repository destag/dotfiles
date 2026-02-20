-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local firstload = not vim.loop.fs_stat(lazypath)
if firstload then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")
require("commands")
require("autocmds")
require("utils")

vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = true,
  float = {
    source = true,
  },
  jump = { float = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  rocks = { enabled = false },
})
