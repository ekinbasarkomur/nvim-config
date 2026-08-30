return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft      = { "rust" },
    config  = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            -- Override K to use rustaceanvim hover actions instead of man
            vim.keymap.set("n", "K", function()
              vim.cmd.RustLsp({ "hover", "actions" })
            end, { buffer = bufnr, silent = true, desc = "Rust: Hover actions" })
          end,
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                allFeatures = true,
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
      }
    end,
  },
}
