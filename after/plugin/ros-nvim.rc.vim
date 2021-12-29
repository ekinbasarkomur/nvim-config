lua << EOF
require 'ros-nvim'.setup {
  catkin_ws_path = "~/Acrome/catkin_ws",
  terminal_height = 8,
  catkin_program = "catkin_make"
}
EOF

nnoremap <silent> rb <cmd>lua require('ros-nvim.build').catkin_make()<cr>
nnoremap <silent> rff <cmd>lua require('ros-nvim.telescope.package').search_package()<cr>
nnoremap <silent> rfg <cmd>lua require('ros-nvim.telescope.package').grep_package()<cr>
nnoremap <silent> rt <cmd>lua require('ros-nvim.telescope.pickers').topic_picker()<cr>
nnoremap <silent> rn <cmd>lua require('ros-nvim.telescope.pickers').node_picker()<cr>
nnoremap <silent> rs <cmd>lua require('ros-nvim.telescope.pickers').service_picker()<cr>
nnoremap <silent> rds <cmd>lua require('ros-nvim.telescope.pickers').srv_picker()<cr>
nnoremap <silent> rdm <cmd>lua require('ros-nvim.telescope.pickers').msg_picker()<cr>
nnoremap <silent> rp <cmd>lua require('ros-nvim.telescope.pickers').param_picker()<cr>
