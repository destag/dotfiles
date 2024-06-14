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

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.relativenumber = true
vim.wo.number = true

vim.o.tabstop = 2      -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2   -- Number of spaces inserted when indenting

-- Enable mouse mode
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamedplus"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn as auto. Set this to 'yes' if you want it enabled
vim.wo.signcolumn = "auto"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Set terminal gui colors to true
vim.o.termguicolors = true
--
-- to enable cursorline!
vim.o.cursorline = true
vim.o.cursorlineopt = "both"

vim.keymap.set("n", "<TAB>", "<cmd>bn<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-TAB>", "<cmd>bp<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>X", "<cmd>bdelete<CR>", { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", ";", ":", { desc = "CMD enter command mode" })

vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })

vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)
vim.keymap.set("n", "[C", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

vim.keymap.set("n", "gh", "<cmd>diffget LOCAL<CR>")
vim.keymap.set("n", "gl", "<cmd>diffget REMOTE<CR>")

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
