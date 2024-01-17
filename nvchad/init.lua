-- local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.relativenumber = true
opt.termguicolors = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.cmd([[hi def NeogitDiffDelete guibg=#932b48 guifg=#f38ba8]])
vim.cmd([[hi def NeogitDiffDeleteHighlight guibg=#932b48 guifg=#f2cdcd]])
vim.cmd([[hi link IlluminatedWordText Visual]])
vim.cmd([[hi link IlluminatedWordRead Visual]])
vim.cmd([[hi link IlluminatedWordWrite Visual]])

vim.filetype.add({
  extension = {
    templ = "templ",
    hcl = "tf",
  },
})
