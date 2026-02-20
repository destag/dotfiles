local function get_tasks()
  local result = vim.system({ "ttrack", "ls", "sdc" }, { text = true }):wait()

  if result.code ~= 0 then
    vim.notify("Listing failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
    return {}
  end

  local items = {}
  for line in result.stdout:gmatch("[^\n]+") do
    local id, desc = line:match("^ (%S+)%s+(.*)$")
    local item = {
      text = desc,
      id = id,
    }
    table.insert(items, item)
  end

  return items
end

local function start_tracking(item)
  if not item or not item.id then return end

  vim.notify("Starting tracking: " .. item.id, vim.log.levels.INFO)

  vim.system({ "ttrack", "start", item.id }, { text = true }, function(res)
    if res.code ~= 0 then
      vim.notify("Failed to start tracking:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      vim.notify("Started " .. item.id, vim.log.levels.INFO)
    end
  end)
end

local function pick_task()
  local snacks = require("snacks")

  local tasks = get_tasks()
  if #tasks == 0 then
    vim.notify("No tasks found", vim.log.levels.WARN)
    return
  end

  snacks.picker({
    title = "Time Tracker",
    items = tasks,
    format = function(item, _) return { { item.id, "Keyword" }, { " " }, { item.text } } end,
    confirm = function(picker, item)
      picker:close()
      start_tracking(item)
    end,
    layout = { preview = false },
  })
end

local function check_task()
  vim.system({ "ttrack" }, { text = true }, function(res)
    if res.code ~= 0 then
      vim.notify("Failed to check tracking:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      vim.notify(res.stdout, vim.log.levels.INFO)
    end
  end)
end

local function stop_task()
  vim.notify("Stopping tracking", vim.log.levels.INFO)

  vim.system({ "ttrack", "finish" }, { text = true }, function(res)
    if res.code ~= 0 then
      vim.notify("Failed to stop tracking:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      vim.notify("Stopped:\n" .. res.stdout, vim.log.levels.INFO)
    end
  end)
end

local function checkout_branch()
  vim.notify("Checkout branch", vim.log.levels.INFO)

  vim.system({ "ttrack", "checkout" }, { text = true }, function(res)
    if res.code ~= 0 then
      vim.notify("Failed to check branch:\n" .. res.stderr, vim.log.levels.ERROR)
    else
      vim.notify("Checkout:\n" .. res.stdout, vim.log.levels.INFO)
    end
  end)
end

vim.api.nvim_create_user_command("TTrack", function() pick_task() end, {})
vim.api.nvim_create_user_command("TTrackCheck", function() check_task() end, {})
vim.api.nvim_create_user_command("TTrackStop", function() stop_task() end, {})
vim.api.nvim_create_user_command("TTrackBranch", function() checkout_branch() end, {})

return {}
