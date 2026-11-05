return {
  -- Catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        nvimtree = true,
        telescope = { enabled = true },
        which_key = true,
        mason = true,
        noice = true,
        notify = true,
        bufferline = true,
        gitsigns = true,
        treesitter = true,
        cmp = true,
        render_markdown = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",  -- auto-detects catppuccin from active colorscheme
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Buffer tabs

  -- Notifications
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
      timeout = 3000,
      render = "compact",
    },
  },

  -- Noice (UI overhaul for cmdline/messages)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = true,
      },
    },
  },

  -- Color highlighter

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Rainbow brackets: colors nested delimiters by nesting depth (treesitter)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },

  -- Markdown rendered in place: headings as coloured bands, code blocks boxed,
  -- bullets and tables redrawn. The line under the cursor stays raw so it can
  -- be edited; <leader>tm shows the whole file raw.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      heading = {
        -- Icon inside the band, band as wide as the text, a blank line's worth
        -- of border above and below so headings stand off the body.
        position = "inline",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
        sign = false,
        width = "block",
        left_pad = 1,
        right_pad = 3,
        min_width = 40,
        border = true,
        border_virtual = true,
      },
      code = {
        sign = false,
        width = "block",
        left_pad = 2,
        right_pad = 2,
        min_width = 60,
        border = "thick",
        language_name = true,
        position = "right",
      },
      bullet = { icons = { "●", "○", "◆", "◇" }, left_pad = 1 },
      checkbox = { enabled = true },
      dash = { width = 60 },
      quote = { repeat_linebreak = true },
      pipe_table = { preset = "round", cell = "padded" },
      link = { enabled = true },
      -- Rendered in normal, command and terminal modes; raw in insert and visual.
      render_modes = { "n", "c", "t" },
    },
    keys = {
      { "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown rendering" },
    },
  },
}
