if !exists('g:loaded_telescope') | finish | endif

nnoremap  <silent> ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap  <silent> fg <cmd>lua require('telescope.builtin').live_grep()<cr>
" nnoremap  <silent> fb <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap  <silent> gs <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap  <silent> gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap  <silent> .. <cmd>Telescope buffers<cr>
nnoremap  <silent> fh <cmd>Telescope help_tags<cr>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  pickers = {
    find_files = {
      hidden = false
    }
  },
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      }
    },
  }
}
require('telescope').load_extension('gh')
require('telescope').load_extension('file_browser')


vim.api.nvim_set_keymap(
  "n",
  "fb",
  "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
  {noremap = true}
)

EOF
