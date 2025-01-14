local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("go", {
  s("przemek", {
    t({ "package main" }),
    t({ "" }),
    t({ "func main() {" }),
    t({ "    " }),
    i(0),
    t({ "" }),
    t({ "}" }),
  }),
})
