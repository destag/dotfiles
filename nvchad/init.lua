-- local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.relativenumber = true
opt.termguicolors = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.filetype.add({
  extension = {
    templ = "templ",
  },
})
