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
      wk.add({
        { "<leader>f", group = "Find / Files" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>c", group = "Code / Claude" },
        { "<leader>d", group = "Diagnostics" },
        { "<leader>b", group = "Buffer" },
        { "<leader>r", group = "Rename" },
      })
    end,
  },

  -- Hardtime: breaks bad Vim habits, enforces motion practice
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      enabled       = true,
      disable_mouse = false,
      hint          = true,
      notification  = true,
      max_time      = 1000,
      max_count     = 2,
      -- Allow arrow keys — remove when comfortable with hjkl
      restricted_keys = {
        ["h"] = { "n", "x" },
        ["j"] = { "n", "x" },
        ["k"] = { "n", "x" },
        ["l"] = { "n", "x" },
      },
      disabledfiletypes = {
        "qf", "netrw", "NvimTree", "lazy", "mason", "help",
        "toggleterm", "Trouble",
      },
    },
  },

  -- Vim-be-good: interactive motion training game
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
  },
}
