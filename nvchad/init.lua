local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.relativenumber = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- autocmd("User", {
--   callback = function()
--     vim.cmd.hi("Cursor", "blend=100")
--     vim.opt.guicursor:append({ "a:Cursor/lCursor" })
--   end,
--   pattern = "LeapEnter",
-- })
-- autocmd("User", {
--   callback = function()
--     vim.cmd.hi("Cursor", "blend=0")
--     vim.opt.guicursor:remove({ "a:Cursor/lCursor" })
--   end,
--   pattern = "LeapLeave",
-- })
