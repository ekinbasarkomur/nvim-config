local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better escape
map("i", "jk", "<Esc>", opts)

-- Arrow keys work everywhere (normal, insert, visual)
map("n", "<Up>",    "k", opts)
map("n", "<Down>",  "j", opts)
map("n", "<Left>",  "h", opts)
map("n", "<Right>", "l", opts)
map("i", "<Up>",    "<Up>",    opts)
map("i", "<Down>",  "<Down>",  opts)
map("i", "<Left>",  "<Left>",  opts)
map("i", "<Right>", "<Right>", opts)
map("v", "<Up>",    "k", opts)
map("v", "<Down>",  "j", opts)
map("v", "<Left>",  "h", opts)
map("v", "<Right>", "l", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window resize
map("n", "<C-Up>",    ":resize +2<CR>",          opts)
map("n", "<C-Down>",  ":resize -2<CR>",           opts)
map("n", "<C-Left>",  ":vertical resize -2<CR>",  opts)
map("n", "<C-Right>", ":vertical resize +2<CR>",  opts)

-- Buffer navigation
map("n", "<Tab>",   ":bnext<CR>",     opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
-- Close the current file and land on the previous one, not on the file tree:
-- switch away first, then delete, so the window keeps whatever it moved to.
map("n", "<leader>bd", function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd("bprevious")
  vim.api.nvim_buf_delete(buf, {})
end, { desc = "Delete buffer, stay on a file" })
-- After an agent has touched thirty files the buffer list is thirty long.
-- Drop every buffer no window shows, keep the unsaved ones.
map("n", "<leader>bD", function()
  local visible = {}
  for _, w in ipairs(vim.api.nvim_list_wins()) do
    visible[vim.api.nvim_win_get_buf(w)] = true
  end
  local n = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted and not visible[b] and not vim.bo[b].modified then
      vim.api.nvim_buf_delete(b, {})
      n = n + 1
    end
  end
  vim.notify("Deleted " .. n .. " hidden buffers")
end, { desc = "Delete every hidden buffer" })

-- Move selected block up/down/left/right
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("v", "H", "<gv", opts)
map("v", "L", ">gv", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Line ends. H and L sit under the home row and read like hjkl: leftmost,
-- rightmost. Visual mode keeps them for indenting, where Shift + a direction
-- means "move the selection that way".
map({ "n", "o" }, "H", "^", opts)
map({ "n", "o" }, "L", "$", opts)

-- Keep the clipboard intact.
-- clipboard=unnamedplus sends every delete to the system clipboard, so one x
-- throws away whatever was copied. Register 0 always holds the last yank.
map({ "n", "v" }, "x", '"_x', opts)
map("v", "p", '"_dP', opts)
map({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste the last yank, not the last delete" })

-- Search
map("n", "<leader>/", ":nohl<CR>", { desc = "Clear search highlight" })
map("n", "n", "nzzzv", opts)  -- keep the match in the middle of the screen
map("n", "N", "Nzzzv", opts)

-- Search and replace. <leader>sp (project-wide) comes from grug-far.
map("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>//gI<Left><Left><Left>",
  { desc = "Replace the word under the cursor, in this file" })
map("v", "<leader>sr", '"zy:%s/<C-r>z//gI<Left><Left><Left>',
  { desc = "Replace the selection, in this file" })
map("n", "<leader>sw", "<cmd>Telescope grep_string<cr>",
  { desc = "Find the word under the cursor, in the project" })
map("n", "<leader>sf", "<cmd>Telescope current_buffer_fuzzy_find<cr>",
  { desc = "Find in this file" })

-- Save / Quit
map("n", "<leader>w", ":w<CR>",  { desc = "Save file" })
map("n", "<leader>q", ":q<CR>",  { desc = "Quit" })

-- Yank for the agent. Telling Claude "this file, this line" is the most
-- common thing said to it; these put that on the clipboard.
local function yank_path(flag)
  local text = vim.fn.expand(flag) .. "#L" .. vim.fn.line(".")
  vim.fn.setreg("+", text)
  vim.notify("Yanked " .. text)
end
map("n", "<leader>yf", function() yank_path("%:.") end, { desc = "Yank relative path#line" })
map("n", "<leader>yp", function() yank_path("%:p") end, { desc = "Yank absolute path#line" })
-- The selection as a fenced code block that names its file and first line.
map("v", "<leader>yc", function()
  local first, last = vim.fn.line("v"), vim.fn.line(".")
  if first > last then first, last = last, first end
  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  local block = { "```" .. vim.bo.filetype .. ' filename="' .. vim.fn.expand("%:.") .. '" line=' .. first }
  vim.list_extend(block, lines)
  table.insert(block, "```")
  vim.fn.setreg("+", table.concat(block, "\n"))
  vim.notify("Yanked " .. #lines .. " lines as a code block")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end, { desc = "Yank selection as a code block" })

-- Terminal exit — use <Esc><Esc> (double escape) to exit terminal mode
-- Single Esc passes through to the running process (e.g. Claude interactive UI)
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
-- One keystroke from the terminal back to the editor on its left.
map("t", "<C-h>", "<C-\\><C-n><C-w>h", opts)
