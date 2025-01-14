-- Use this file for any UI based plugins
-- Contains telescope, icons, lualine & whichkey
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    init = function()
      local builtin = require("telescope.builtin")
      local wk = require("which-key")
      wk.add({
        { "<leader>ff", builtin.find_files, desc = "Find File" },
        { "<leader>fb", builtin.buffers, desc = "Find Buffer" },
        { "<leader>fg", builtin.live_grep, desc = "Find with Grep" },
        {
          "<leader>fo",
          function() builtin.oldfiles({ cwd_only = true }) end,
          desc = "Find Old Files",
        },
        { "<leader>fh", builtin.help_tags, desc = "Find Help" },
        { "<leader>fd", builtin.diagnostics, desc = "Find Diagnostics" },
        { "<leader>fm", "<cmd>MarksListAll<CR><cmd>lcl<CR><cmd>Telescope loclist<CR>", desc = "Find Mark" },
      })
    end,
    opts = function()
      return {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          previewer = true,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
        },
        extensions_list = {
          "file_browser",
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
    },
  },
  -- Only load whichkey after all the gui
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    cmd = "WhichKey",
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>r", group = "Refactor" },
        { "<leader>h", group = "Git" },
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signs_staged = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next Hunk" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous Hunk" })

          -- Actions
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
          map(
            "v",
            "<leader>hs",
            function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Stage Hunk" }
          )
          map(
            "v",
            "<leader>hr",
            function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
            { desc = "Reset Hunk" }
          )
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage Buffer" })
          map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Unstage Hunk" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset Buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
          map("n", "<leader>hB", function() gitsigns.blame() end, { desc = "Blame Buffer" })
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff hunk" })
          map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff buffer" })
          map("n", "<leader>td", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
      {
        "gr",
        "<cmd>Trouble lsp_references toggle<cr>",
        desc = "LSP References (Trouble)",
      },
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = " ",
      },
      scope = {
        enabled = true,
        char = "▎",
        show_exact_scope = true,
        show_start = false,
        show_end = false,
      },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        bind = true,
        -- doc_lines = 0,
        handler_opts = {
          border = "rounded",
        },
        floating_window = false,
        hint_enable = false,
        hint_prefix = {
          above = "↙ ", -- when the hint is on the line above the current line
          current = "← ", -- when the hint is on the same line
          below = "↖ ", -- when the hint is on the line below the current line
        },
        toggle_key = "<C-s>",
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
}
