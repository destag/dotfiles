local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("elixir", {
  s(">", fmt("|> {}", { i(0) })),
  s(">ins", fmt('|> IO.inspect(label: "{}")', { i(0) })),
  s(">dbg", fmt("|> dbg()", {})),
})
