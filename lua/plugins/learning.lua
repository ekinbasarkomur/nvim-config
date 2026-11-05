return {
  -- Which-key: shows available keybindings popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout    = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = {
          marks     = true,
          registers = true,
          spelling  = { enabled = true, suggestions = 20 },
        },
        -- which-key v3 API: use win instead of window
        win = {
          border  = "rounded",
          padding = { 1, 2 },
        },
        layout = { align = "center" },
        icons = { mappings = false },  -- disable mini.icons dependency
      })
      -- which-key v3 API: use add() with group instead of register()
      -- One letter, one noun. Everything about that noun lives under it.
      wk.add({
        { "<leader>a",  group = "AI / Claude" },
        { "<leader>b",  group = "Buffer" },
        { "<leader>c",  group = "Code: action, rename, format" },
        { "<leader>d",  group = "Debug (DAP)" },
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>gh", group = "Hunk" },
        { "<leader>s",  group = "Search / Replace" },
        { "<leader>x",  group = "Diagnostics" },
        { "<leader>y",  group = "Yank for the agent" },
      })
    end,
  },


}
