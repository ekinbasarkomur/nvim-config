return {
  -- File tree
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Disable netrw (recommended by nvim-tree)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        view = { width = 30 },
        renderer = {
          group_empty = true,
          icons = {
            show = { git = true, file = true, folder = true, folder_arrow = true },
          },
        },
        filters = { dotfiles = false },
        git = { enable = true, ignore = false },
        actions = {
          open_file = {
            quit_on_open = false,
            window_picker = {
              enable = false,
            },
          },
        },
        on_attach = "default",
      })
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>",
        { desc = "Toggle file tree", silent = true })
    end,
  },

  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope-file-browser.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      local builtin   = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_display     = { "truncate" },
          sorting_strategy = "ascending",
          layout_strategy  = "flex",
          layout_config    = {
            prompt_position = "top",
            flex = {
              flip_columns = 120,   -- horizontal on wide, vertical on narrow
            },
            horizontal = {
              preview_width  = 0.55,
              results_width  = 0.45,
              preview_cutoff = 80,
            },
            vertical = {
              preview_height = 0.5,
              preview_cutoff = 20,
            },
            width  = 0.95,
            height = 0.90,
          },
          preview = {
            timeout         = 300,
            filesize_limit  = 1,    -- MB
            treesitter      = false, -- nvim-treesitter v2 broke ft_to_lang; use native syntax instead
            hide_on_startup = false,
          },
          mappings = {
            i = {
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-q>"] = require("telescope.actions").send_to_qflist,
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
            n = {
              ["<C-p>"] = require("telescope.actions.layout").toggle_preview,
            },
          },
        },
        pickers = {
          find_files = {
            hidden    = true,   -- show dotfiles
            previewer = true,
          },
          live_grep = {
            previewer = true,
          },
          help_tags = {
            previewer = true,
          },
          buffers = {
            previewer    = true,
            sort_lastused = true,
            sort_mru     = true,
          },
        },
        extensions = {
          file_browser = { hijack_netrw = true },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      local map = vim.keymap.set
      map("n", "<leader>ff", builtin.find_files,  { desc = "Find files" })
      map("n", "<leader>fg", builtin.live_grep,   { desc = "Live grep" })
      map("n", "<leader>fb", builtin.buffers,     { desc = "Buffers" })
      map("n", "<leader>fr", builtin.oldfiles,    { desc = "Recent files" })
      map("n", "<leader>fh", builtin.help_tags,   { desc = "Help tags" })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({})
      local ts_install = require("nvim-treesitter.install")
      ts_install.prefer_git = false
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 15,
      open_mapping = [[<C-\>]],
      direction    = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    lazy = false,
    opts = {},
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
}
