return {
  -- Claude Code integration (right pane, <leader>cc)
  -- Using the official claude-code.nvim plugin
  {
    "coder/claudecode.nvim",
    -- fallback: if this repo doesn't exist, try "greggroth/claude-code.nvim"
    opts = {
      terminal_cmd = "claude",
      side_by_side = true,
      split_side = "right",
      split_width_percentage = 0.4,
    },
    keys = {
      { "<leader>cc", "<cmd>ClaudeCode<cr>",       desc = "Toggle Claude Code" },
      { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",   desc = "Send to Claude",    mode = "v" },
      { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",  desc = "Focus Claude pane" },
    },
  },

  -- Avante.nvim — inline Cursor-style AI assistant
  {
    "yetone/avante.nvim",
    event   = "VeryLazy",
    version = false,
    build   = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name  = false,
            drag_and_drop         = { insert_mode = true },
            use_absolute_path     = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft   = { "markdown", "Avante" },
      },
    },
    opts = {
      provider               = "claude",
      auto_suggestions_provider = "claude",
      -- avante v2 API: provider config goes under providers table
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model    = "claude-sonnet-4-5",
          extra_request_body = {
            temperature = 0,
            max_tokens  = 4096,
          },
        },
      },
      behaviour = {
        auto_suggestions                 = false,
        auto_set_highlight_group         = true,
        auto_set_keymaps                 = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard     = false,
      },
      hints = { enabled = true },
      windows = {
        position = "right",
        wrap     = true,
        width    = 40,
        sidebar_header = {
          enabled = true,
          align   = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = { current = "DiffText", incoming = "DiffAdd" },
      },
      diff = {
        autojump          = true,
        list_opener       = "copen",
        override_timeoutlen = 500,
      },
    },
  },
}
