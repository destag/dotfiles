local chat_system_prompt = [[You are a general AI assistant.

The user provided the additional info about how they would like you to respond:

- If you're unsure don't guess and say you don't know instead.
- Ask question if you need clarification to provide better answer.
- Think deeply and carefully from first principles step by step.
- Zoom out first to see the big picture and then zoom in to details.
- Use Socratic method to improve your thinking and coding skills.
- Don't elide any code from your output if the answer requires coding.
- Take a deep breath; You've got this!
]]

local code_system_prompt = [[You are an AI working as a code editor.

Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.
START AND END YOUR ANSWER WITH:

```]]

return {
  {
    "robitx/gp.nvim",
    keys = {
      { "<leader>pc", "<cmd>PrtChatNew vsplit<cr>", mode = { "n" }, desc = "New Chat" },
      { "<leader>pc", ":<C-u>'<,'>PrtChatNew vsplit<cr>", mode = { "v" }, desc = "Visual Chat New" },
      { "<leader>pt", "<cmd>PrtChatToggle<cr>", mode = { "n" }, desc = "Toggle Popup Chat" },
      { "<leader>pr", ":<C-u>'<,'>PrtRewrite<cr>", mode = { "v" }, desc = "Visual Rewrite" },
      { "<leader>pa", "<cmd>PrtAppend<cr>", mode = { "n" }, desc = "Append" },
      { "<leader>pa", ":<C-u>'<,'>PrtAppend<cr>", mode = { "v" }, desc = "Visual Append" },
      { "<leader>po", "<cmd>PrtPrepend<cr>", mode = { "n" }, desc = "Prepend" },
      { "<leader>po", ":<C-u>'<,'>PrtPrepend<cr>", mode = { "v" }, desc = "Visual Prepend" },
      { "<leader>pm", "<cmd>PrtSelectAgent<cr>", mode = { "n" }, desc = "Select model" },
      { "<leader>pq", "<cmd>PrtPopup<cr>", mode = { "n" }, desc = "Ask a question" },
      { "<leader>px", "<cmd>PrtContext<cr>", mode = { "n" }, desc = "Open context file" },
      { "<leader>pi", ":<C-u>'<,'>PrtImplement<cr>", mode = { "v" }, desc = "Visual Implement" },
      { "<leader>pe", ":<C-u>'<,'>PrtExplain<cr>", mode = { "v" }, desc = "Visual Explain" },
      { "<leader>py", ":<C-u>'<,'>PrtChatPaste<cr>", mode = { "v" }, desc = "Paste to Chat" },
    },
    opts = {
      cmd_prefix = "Prt",
      chat_free_cursor = true,
      image = { disable = true },
      whisper = { disable = true },
      providers = {
        openai = {
          disable = true,
        },
        groq = {
          disable = false,
          endpoint = "https://api.groq.com/openai/v1/chat/completions",
          secret = { "pass", "show", "groq/apikey" },
        },
        googleai = {
          disable = false,
          endpoint = "https://generativelanguage.googleapis.com/v1beta/models/{{model}}:streamGenerateContent?key={{secret}}",
          secret = { "pass", "show", "gemini/apikey" },
        },
      },
      agents = {
        {
          name = "ChatGroq",
          chat = true,
          command = false,
          provider = "groq",
          model = "openai/gpt-oss-20b",
          system_prompt = chat_system_prompt,
        },
        {
          name = "CodeGroq",
          chat = false,
          command = true,
          provider = "groq",
          model = "openai/gpt-oss-20b",
          system_prompt = code_system_prompt,
        },
        {
          name = "ChatLlama",
          chat = true,
          command = false,
          provider = "groq",
          model = "llama-3.1-8b-instant",
          system_prompt = chat_system_prompt,
        },
        {
          name = "CodeLlama",
          chat = false,
          command = true,
          provider = "groq",
          model = "llama-3.1-8b-instant",
          system_prompt = code_system_prompt,
        },
        {
          name = "ChatGemini",
          chat = true,
          command = false,
          provider = "googleai",
          model = { model = "gemini-2.5-flash" },
          system_prompt = chat_system_prompt,
        },
        {
          name = "CodeGemini",
          chat = false,
          command = true,
          provider = "googleai",
          model = { model = "gemini-2.5-flash" },
          system_prompt = code_system_prompt,
        },
      },
      hooks = {
        Explain = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by explaining the code above."
          local agent = gp.get_chat_agent()
          gp.Prompt(params, gp.Target.popup, agent, template)
        end,
      },
    },
  },
}
