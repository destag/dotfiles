local ls = require("luasnip")
local fmta = require("luasnip.extras.fmt").fmta
local s = ls.snippet
local d = ls.dynamic_node
local i = ls.insert_node
local t = ls.text_node
local sn = ls.snippet_node
local c = ls.choice_node

-- Keep the default values map
local default_values = {
  int = "0",
  bool = "false",
  string = '""',

  error = function(_, info)
    if info then
      info.index = info.index + 1
      return c(info.index, {
        t(info.err_name),
        t(string.format('errors.Wrap(%s, "%s")', info.err_name, info.func_name)),
      })
    else
      return t("err")
    end
  end,

  [function(text) return string.find(text, "*", 1, true) ~= nil end] = function(_, _) return t("nil") end,

  [function(text)
    return not string.find(text, "*", 1, true) and string.upper(string.sub(text, 1, 1)) == string.sub(text, 1, 1)
  end] = function(text, info)
    info.index = info.index + 1
    return c(info.index, {
      t(text .. "{}"),
      t(text),
    })
  end,
}

-- Keep the transform function
local transform = function(text, info)
  local condition_matches = function(condition, ...)
    if type(condition) == "string" then
      return condition == text
    else
      return condition(...)
    end
  end

  for condition, result in pairs(default_values) do
    if condition_matches(condition, text, info) then
      if type(result) == "string" then
        return t(result)
      else
        return result(text, info)
      end
    end
  end

  return t(text)
end

-- Keep the handlers
local handlers = {
  parameter_list = function(node, info)
    local result = {}

    local count = node:named_child_count()
    for idx = 0, count - 1 do
      local matching_node = node:named_child(idx)
      local type_node = matching_node:field("type")[1]
      table.insert(result, transform(vim.treesitter.get_node_text(type_node, 0), info))
      if idx ~= count - 1 then table.insert(result, t({ ", " })) end
    end

    return result
  end,

  type_identifier = function(node, info)
    local text = vim.treesitter.get_node_text(node, 0)
    return { transform(text, info) }
  end,
}

-- Keep the go_result_type function
local function go_result_type(info)
  local function_node_types = {
    function_declaration = true,
    method_declaration = true,
    func_literal = true,
  }

  local node = vim.treesitter.get_node()
  while node ~= nil do
    if function_node_types[node:type()] then break end
    node = node:parent()
  end

  if not node then
    vim.notify("Not inside of a function")
    return t("")
  end

  local query = assert(vim.treesitter.query.get("go", "return-snippet"), "No query")
  for _, capture in query:iter_captures(node, 0) do
    if handlers[capture:type()] then return handlers[capture:type()](capture, info) end
  end
end

local go_return_values = function(args)
  return sn(
    nil,
    go_result_type({
      index = 0,
      err_name = args[1][1],
      func_name = "function", -- Since we don't have the function name anymore
    })
  )
end

-- Modified snippet without the first line
ls.add_snippets("go", {
  s(
    "efi",
    fmta(
      [[if <err> != nil {
	return <result>
}
<finish>]],
      {
        err = i(1, "err"),
        result = d(2, go_return_values, { 1 }),
        finish = i(0),
      }
    )
  ),
})
