local create_adapter = function(adapter)
  local cmd = string.format("cmd:echo -n `pass show %s/apikey`", adapter)
  return function()
    return require("codecompanion.adapters").extend(adapter, {
      env = { api_key = cmd },
    })
  end
end

return {
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    opts = {
      filter = function(bufnr)
        local path = vim.fn.bufname(bufnr)
        local name = vim.fs.basename(path)
        return name ~= ".env" and name ~= ".envrc"
      end,
    },
    keys = {
      { "<A-a>", mode = "i", function() require("neocodeium").accept() end },
      { "<A-w>", mode = "i", function() require("neocodeium").accept_word() end },
      { "<A-l>", mode = "i", function() require("neocodeium").accept_line() end },
      { "<A-n>", mode = "i", function() require("neocodeium").cycle_or_complete() end },
      { "<A-m>", mode = "i", function() require("neocodeium").cycle_or_complete(-1) end },
      { "<A-c>", mode = "i", function() require("neocodeium").clear() end },
      { "<A-s>", mode = "i", function() require("neocodeium").show() end },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Toggle (CodeCompanion)",
        mode = { "n", "v" },
      },
      {
        "<leader>cx",
        "<cmd>CodeCompanion<cr>",
        desc = "CodeCompanion",
        mode = { "n", "v" },
      },
    },
    opts = {
      strategies = {
        chat = { adapter = vim.g.ai_model or "gemini" },
        inline = { adapter = vim.g.ai_model or "gemini" },
      },
      adapters = {
        gemini = create_adapter("gemini"),
        deepseek = create_adapter("deepseek"),
        ollama = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = { url = "http://serwerzu:11434" },
            schema = { model = { default = "deepseek-coder:1.3b" } },
          })
        end,
      },
    },
  },
}
