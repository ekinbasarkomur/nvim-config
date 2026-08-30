return {
  -- Mason: LSP/formatter/linter installer UI
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig bridge (LSP servers only)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      -- rust-analyzer  → rustup component (rustaceanvim manages it)
      -- clangd         → system (Xcode CLT / Apple clangd 21)
      -- ruff           → pip (~/.local/bin)
      -- clang-format   → system
      ensure_installed = { "lua_ls", "pyright", "ts_ls" },
      automatic_installation = true,
    },
  },

  -- Mason non-LSP tools (formatters, DAP adapters)
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua",    -- Lua formatter
        "codelldb",  -- DAP adapter for Rust + C++
      },
      auto_update    = false,
      run_on_start   = true,
    },
  },

  -- Neodev: better Lua/Neovim API completion
  {
    "folke/neodev.nvim",
    opts = {},
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, {
              buffer = bufnr,
              desc = "LSP: " .. desc,
              noremap = true,
              silent = true,
            })
          end

          map("gd", vim.lsp.buf.definition,      "Go to definition")
          map("gD", vim.lsp.buf.declaration,     "Go to declaration")
          map("gr", vim.lsp.buf.references,      "References")
          map("gi", vim.lsp.buf.implementation,  "Implementation")
          map("K",  vim.lsp.buf.hover,           "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename,       "Rename")
          map("<leader>ca", vim.lsp.buf.code_action,  "Code action")
          map("<leader>D",  vim.lsp.buf.type_definition, "Type definition")
          map("[d", vim.diagnostic.goto_prev,    "Prev diagnostic")
          map("]d", vim.diagnostic.goto_next,    "Next diagnostic")
          map("<leader>dl", vim.diagnostic.open_float, "Diagnostic float")

          -- Signature help in insert mode
          vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, {
            buffer = bufnr,
            desc = "LSP: Signature help",
            noremap = true,
            silent = true,
          })
        end,
      })

      local servers = {
        lua_ls = {
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME },
              },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {
          capabilities = capabilities,
        },
        ts_ls = {
          capabilities = capabilities,
        },
        -- C++ — system clangd (Apple clangd 21, installed via Xcode CLT)
        -- Reads compile_commands.json from build/ automatically
        clangd = {
          capabilities = capabilities,
          cmd = { "clangd", "--background-index", "--clang-tidy" },
        },
        -- Rust — rust-analyzer via rustup component
        -- rustaceanvim manages its own server start; skip here if rustaceanvim is active
        rust_analyzer = {
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
      }

      for server_name, config in pairs(servers) do
        -- rustaceanvim handles rust_analyzer itself; don't double-start it
        if server_name ~= "rust_analyzer" then
          vim.lsp.config(server_name, config)
          vim.lsp.enable(server_name)
        end
      end

      -- Store rust_analyzer config for rustaceanvim to pick up
      vim.g.rust_analyzer_config = servers.rust_analyzer.settings

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })
    end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp     = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"]     = cmp.mapping.select_prev_item(),
          ["<C-j>"]     = cmp.mapping.select_next_item(),
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
