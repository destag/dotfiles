-- Use this file for any UI based plugins
-- Contains icons, lualine & whichkey
return {
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "bwpge/lualine-pretty-path",
    },
    event = "VeryLazy",
    opts = function()
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name}",
        hl_group = "lualine_c_normal",
      })

      local neocodeium_status = function()
        local status, _ = require("neocodeium").get_status()
        if status == 0 then
          return "󰘦 "
        else
          return ""
        end
      end

      local neocodeium_color = function()
        local _, server_status = require("neocodeium").get_status()

        local hl_name = "Normal"
        if server_status == 1 then
          hl_name = "WarningMsg"
        elseif server_status == 2 then
          hl_name = "ErrorMsg"
        end

        local hl = vim.api.nvim_get_hl(0, { name = hl_name })
        return hl and hl.fg and { fg = string.format("#%06x", hl.fg) } or {}
      end

      local opts = {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = "|",
          section_separators = { left = "", right = "" },
          disabled_filetypes = { statusline = { "snacks_dashboard" } },
        },
        sections = {
          lualine_c = {
            {
              function() return "󰛢 " .. require("grapple").name_or_index() end,
              cond = function() return package.loaded["grapple"] and require("grapple").exists() end,
            },
            { "pretty_path", icon_show = false },
            {
              symbols and symbols.get,
              cond = function() return symbols.has() and false end,
            },
          },
          lualine_x = {
            {
              neocodeium_status,
              color = neocodeium_color,
            },
            "lsp_status",
            { "encoding", cond = function() return (vim.bo.fenc or vim.go.enc) ~= "utf-8" end },
            { "fileformat", cond = function() return vim.bo.fileformat ~= "unix" end },
            "filetype",
          },
        },
      }

      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>r", group = "Refactor" },
        { "<leader>h", group = "Git" },
        { "<leader>s", group = "Search" },
        { "<leader>u", group = "Toggle" },
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
          map("n", "]h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Next Hunk" })

          map("n", "]H", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next", { target = "all" })
            end
          end, { desc = "Next Hunk" })

          map("n", "[h", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Previous Hunk" })

          map("n", "[H", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev", { target = "all" })
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
          map("n", "<leader>hp", gitsigns.preview_hunk_inline, { desc = "Preview Hunk" })
          map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Blame Line" })
          map("n", "<leader>hB", function() gitsigns.blame() end, { desc = "Blame Buffer" })
          map("n", "<leader>ub", gitsigns.toggle_current_line_blame, { desc = "Toggle Current Line Blame" })
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
    specs = {
      "folke/snacks.nvim",
      opts = function(_, opts)
        return vim.tbl_deep_extend("force", opts or {}, {
          picker = {
            actions = require("trouble.sources.snacks").actions,
            win = {
              input = {
                keys = {
                  ["<c-t>"] = {
                    "trouble_open",
                    mode = { "n", "i" },
                  },
                },
              },
            },
          },
        })
      end,
    },
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
    },
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },
  {
    "brenoprata10/nvim-highlight-colors",
    ft = { "html", "css" },
    opts = {
      render = "virtual",
      enable_tailwind = true,
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
