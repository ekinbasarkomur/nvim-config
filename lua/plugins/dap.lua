return {
  -- Mason-DAP bridge: otomatik codelldb kurulumu
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = { "codelldb" },
      automatic_installation = true,
    },
  },

  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap   = require("dap")
      local dapui = require("dapui")

      -- ── CodeLLDB adapter (Rust + C++) ──────────────────────────────
      local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args    = { "--port", "${port}" },
        },
      }

      -- ── Rust ───────────────────────────────────────────────────────
      dap.configurations.rust = {
        {
          name    = "Launch binary",
          type    = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Binary: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }

      -- ── C++ ────────────────────────────────────────────────────────
      dap.configurations.cpp = {
        {
          name    = "Launch binary",
          type    = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Binary: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }

      dap.configurations.c = dap.configurations.cpp

      -- ── UI ─────────────────────────────────────────────────────────
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.40 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks",      size = 0.20 },
              { id = "watches",     size = 0.20 },
            },
            size     = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl",    size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size     = 12,
            position = "bottom",
          },
        },
      })

      -- UI otomatik aç/kapat
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]     = function() dapui.close() end

      -- ── Virtual text ───────────────────────────────────────────────
      require("nvim-dap-virtual-text").setup()

      -- ── Keymaps ────────────────────────────────────────────────────
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { silent = true, desc = "DAP: " .. desc })
      end

      map("<F5>",        dap.continue,         "Continue / Start")
      map("<F10>",       dap.step_over,         "Step over")
      map("<F11>",       dap.step_into,         "Step into")
      map("<F12>",       dap.step_out,          "Step out")
      map("<leader>db",  dap.toggle_breakpoint, "Toggle breakpoint")
      map("<leader>dB",  function()
        dap.set_breakpoint(vim.fn.input("Condition: "))
      end, "Conditional breakpoint")
      map("<leader>dr",  dap.repl.open,         "Open REPL")
      map("<leader>du",  dapui.toggle,          "Toggle UI")
      map("<leader>dx",  dap.terminate,         "Terminate")
    end,
  },
}
