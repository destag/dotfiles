local M = {}

M.P = function(str)
  print(vim.inspect(str))
  return str
end

_G.P = M.P

return M
