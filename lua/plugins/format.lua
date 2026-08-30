return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd   = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        python     = { "ruff_format", "ruff_organize_imports" },
        rust       = { "rustfmt" },       -- rust-analyzer / rustup
        cpp        = { "clang_format" },  -- clang-format ships with llvm/Xcode CLT
        c          = { "clang_format" },
        lua        = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      -- Format on save; timeout generous enough for ruff on large files
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    },
  },
}
