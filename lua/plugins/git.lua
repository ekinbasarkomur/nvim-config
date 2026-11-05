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
        -- Everything git lives under <leader>g; hunks one level down at gh.
        map("n", "<leader>ghs", gs.stage_hunk,   "Stage hunk")
        map("n", "<leader>ghr", gs.reset_hunk,   "Reset hunk")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage whole buffer")
        map("n", "<leader>gb",  gs.blame_line,   "Blame this line")
        map("n", "<leader>gd",  gs.diffthis,     "Diff this file")
      end,
    },
  },

  -- Lazygit in a floating terminal. toggleterm is already here, so no extra
  -- plugin: one hidden terminal, toggled.
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<leader>gg",
        function()
          if not _G.lazygit_term then
            _G.lazygit_term = require("toggleterm.terminal").Terminal:new({
              cmd = "lazygit",
              direction = "float",
              hidden = true,
              float_opts = { border = "rounded", width = function() return math.floor(vim.o.columns * 0.9) end },
            })
          end
          _G.lazygit_term:toggle()
        end,
        desc = "Lazygit",
      },
    },
  },

  -- Diff layer 2: the old text drawn inline over the buffer. gitsigns keeps
  -- the gutter and the hunk actions; this only adds the overlay, so its own
  -- signs and mappings are off.
  {
    "nvim-mini/mini.diff",
    opts = {
      view = { style = "number" },
      mappings = {
        apply = "", reset = "", textobject = "",
        goto_first = "", goto_prev = "", goto_next = "", goto_last = "",
      },
    },
    keys = {
      {
        "<leader>go",
        function() require("mini.diff").toggle_overlay(0) end,
        desc = "Toggle diff overlay",
      },
    },
  },

  -- Diff layer 3: every changed file side by side, with a file tree. For
  -- the moment after an agent touched twenty files.
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = {
      explorer = { width = 40, view_mode = "tree", line_stats = { enabled = true } },
      diff = { compact = true, compact_context_lines = 8 },
    },
    keys = {
      { "<leader>gv", "<cmd>CodeDiff<cr>",           desc = "Diff view: all changes" },
      { "<leader>gl", "<cmd>CodeDiff history %<cr>", desc = "Log of this file" },
      { "<leader>gL", "<cmd>CodeDiff history<cr>",   desc = "Log of the repo" },
    },
  },
}
