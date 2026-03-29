local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Session persistence — save on exit, restore on start (per working directory)
local session_dir = vim.fn.stdpath("data") .. "/sessions"
vim.fn.mkdir(session_dir, "p")

local function session_file()
  local cwd = vim.fn.getcwd():gsub("[/\\:%%]", "%%")
  return session_dir .. "/" .. cwd .. ".vim"
end

-- Auto-restore when nvim opens with no file args
if vim.fn.argc() == 0 then
  local sf = session_file()
  if vim.fn.filereadable(sf) == 1 then
    vim.schedule(function()
      vim.cmd("silent! source " .. vim.fn.fnameescape(sf))
    end)
  end
end

-- Auto-save on exit
autocmd("VimLeavePre", {
  group = augroup("SessionSave", { clear = true }),
  callback = function()
    vim.cmd("silent! mksession! " .. vim.fn.fnameescape(session_file()))
  end,
})

-- Highlight on yank
local yank_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
local trim_group = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = trim_group,
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Resize splits on window resize
autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close certain filetypes with q
autocmd("FileType", {
  pattern = { "qf", "help", "man", "notify", "lspinfo" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})
