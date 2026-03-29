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
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Move lines in visual mode
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Clear search
map("n", "<leader>/", ":nohl<CR>", { desc = "Clear search highlight" })

-- Save / Quit
map("n", "<leader>w", ":w<CR>",  { desc = "Save file" })
map("n", "<leader>q", ":q<CR>",  { desc = "Quit" })

-- Terminal exit — use <Esc><Esc> (double escape) to exit terminal mode
-- Single Esc passes through to the running process (e.g. Claude interactive UI)
map("t", "<Esc><Esc>", "<C-\\><C-n>", opts)
