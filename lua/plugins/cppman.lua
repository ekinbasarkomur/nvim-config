return {
  {
    "gauteh/vim-cppman",
    ft = { "cpp", "c" },
    config = function()
      -- C/C++ dosyalarında K → cppman (LSP hover yerine)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "cpp", "c" },
        callback = function()
          vim.keymap.set("n", "K", function()
            local word = vim.fn.expand("<cword>")
            vim.cmd("Cppman " .. word)
          end, {
            buffer = true,
            desc = "cppman: C++ docs",
            noremap = true,
            silent = true,
          })
        end,
      })
    end,
  },
}
