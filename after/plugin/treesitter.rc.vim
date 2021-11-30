if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua <<EOF
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "cmake",
    "cpp",
    "css",
    "fish",
    "gdscript",
    "glsl",
    "html",
    "javascript",
    "json",
    "python",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  }
}
EOF
