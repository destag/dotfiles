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
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
})

-- add binaries installed by mason.nvim to path
local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

require("lazy").setup("plugins")

if firstload then
  vim.schedule(function()
    vim.cmd("MasonInstallAll")

    local packages = {}
    for k, v in pairs(vim.g.mason_binaries_list) do
      packages[k] = v
    end

    local installed = {}

    require("mason-registry"):on("package:install:success", function(pkg)
      table.insert(installed, pkg.name)

      if #installed == #packages then
        vim.schedule(function()
          vim.api.nvim_buf_delete(0, { force = true })
          vim.api.nvim_buf_delete(0, { force = true })
          vim.cmd("echo '' | redraw")
        end)
      end
    end)
  end)
end
