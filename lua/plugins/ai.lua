return {
  -- Claude Code inside the editor. Unlike a chat plugin with its own API key,
  -- this speaks the same WebSocket protocol as the VS Code extension, so it
  -- drives the Claude Code CLI you already pay for. Selections go out as
  -- context; what Claude proposes comes back as a diff you accept or reject.
  {
    "coder/claudecode.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      terminal = { split_side = "right", split_width_percentage = 0.35 },
      diff_opts = { vertical_split = true },
    },
    keys = {
      { "<leader>a",  nil,                              desc = "AI / Claude" },
      { "<leader>aa", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
      { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue the last session" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume a session (pick one)" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Send this buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send selection", mode = "v" },
      { "<leader>ay", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept the diff" },
      { "<leader>an", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Reject the diff" },
    },
  },
}
