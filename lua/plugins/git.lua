return {
  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs  = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end
        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, "Next hunk")
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, "Prev hunk")
        -- Actions
        map("n", "<leader>hs", gs.stage_hunk,   "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk,   "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hb", gs.blame_line,   "Blame line")
        map("n", "<leader>hd", gs.diffthis,     "Diff this")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
      end,
    },
  },

  -- Fugitive (Git commands from Vim)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gwrite", "Gread", "Gdiffsplit" },
    keys = {
      { "<leader>gs", "<cmd>Git<cr>",        desc = "Git status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<cr>",   desc = "Git push" },
      { "<leader>gl", "<cmd>Git log<cr>",    desc = "Git log" },
    },
  },
}
