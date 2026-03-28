# Ekin's Neovim Config

A modern, full-featured Neovim setup built from scratch for 2026. Designed for a developer returning to Neovim after a break — beginner-friendly keybinding hints, AI integration, clean aesthetics, and a solid LSP stack.

---

## Table of Contents

1. [Requirements](#requirements)
2. [Installation](#installation)
3. [File Structure](#file-structure)
4. [Theme](#theme)
5. [Plugin List](#plugin-list)
6. [Keybindings Reference](#keybindings-reference)
7. [LSP — Language Servers](#lsp--language-servers)
8. [AI Integration](#ai-integration)
9. [Learning Tools](#learning-tools)
10. [Telescope — Fuzzy Finder](#telescope--fuzzy-finder)
11. [Terminal](#terminal)
12. [Git Integration](#git-integration)
13. [Troubleshooting](#troubleshooting)

---

## Requirements

| Tool | Version | Install |
|------|---------|---------|
| Neovim | 0.11+ | `brew install neovim` |
| Git | any | `brew install git` |
| Node.js | 18+ | `brew install node` |
| Python | 3.x | `brew install python` |
| A Nerd Font | any | [nerdfonts.com](https://www.nerdfonts.com) |
| `make` | any | Xcode CLT |
| `ripgrep` | any | `brew install ripgrep` (for live grep) |
| `fd` | any | `brew install fd` (for file finding) |

**Ghostty terminal** (recommended):
```
background-opacity = 0.85
background-blur-radius = 20
font-family = "JetBrainsMono Nerd Font"
font-size = 14
theme = tokyonight
```

---

## Installation

### Fresh Install

```bash
# Backup existing config if any
mv ~/.config/nvim ~/.config/nvim.bak

# Clone or copy this config
cp -r /path/to/this/config ~/.config/nvim

# Open Neovim — lazy.nvim auto-installs everything
nvim
```

On first launch, `lazy.nvim` will bootstrap itself and install all 40 plugins automatically. Wait for it to finish, then restart nvim.

### Install LSP Servers

After nvim opens:

```
:Mason
```

This opens the Mason UI. Press `i` on any server to install. The following are pre-configured and auto-installed:
- `lua-language-server` — Lua (for editing this config)
- `pyright` — Python
- `typescript-language-server` — TypeScript / JavaScript

### Update Plugins

```
:Lazy sync
```

### Update Treesitter Parsers

```
:TSUpdate
```

---

## File Structure

```
~/.config/nvim/
├── init.lua                    ← Entry point: loads core + plugins
├── README.md                   ← This file
└── lua/
    ├── core/
    │   ├── options.lua         ← Editor settings (line numbers, tabs, clipboard, etc.)
    │   ├── keymaps.lua         ← All custom keybindings
    │   └── autocmds.lua        ← Auto-commands (highlight on yank, etc.)
    └── plugins/
        ├── init.lua            ← lazy.nvim bootstrap + plugin imports
        ├── ui.lua              ← Theme, statusline, bufferline, notifications
        ├── editor.lua          ← File tree, fuzzy finder, treesitter, terminal, editing
        ├── lsp.lua             ← Language servers, completion, snippets
        ├── git.lua             ← Git signs, fugitive
        ├── ai.lua              ← Claude Code, Avante AI
        └── learning.lua        ← which-key, hardtime, vim-be-good
```

### Plugin Manager

This config uses **[lazy.nvim](https://github.com/folke/lazy.nvim)** — the standard modern Neovim plugin manager. It lazy-loads plugins for fast startup and provides a clean UI at `:Lazy`.

---

## Theme

**[Catppuccin Mocha](https://github.com/catppuccin/nvim)** — a warm dark pastel theme with full plugin integration.

- `transparent_background = true` — lets your terminal blur/opacity show through
- Integrated with: treesitter, telescope, nvim-tree, bufferline, gitsigns, which-key, noice, nvim-cmp

Change flavour in `lua/plugins/ui.lua`:
```lua
flavour = "mocha"   -- options: latte, frappe, macchiato, mocha
```

---

## Plugin List

### UI

| Plugin | Purpose |
|--------|---------|
| `catppuccin/nvim` | Catppuccin Mocha theme with transparent background |
| `nvim-lualine/lualine.nvim` | Status line at the bottom (mode, branch, diagnostics, position) |
| `akinsho/bufferline.nvim` | Buffer tabs at the top of the screen |
| `rcarriga/nvim-notify` | Floating notification toasts |
| `folke/noice.nvim` | Replaces the command line and messages with floating UI |
| `norcalli/nvim-colorizer.lua` | Highlights hex color codes inline (e.g. `#ff0000`) |
| `nvim-tree/nvim-web-devicons` | File type icons used across plugins |

### Editor

| Plugin | Purpose |
|--------|---------|
| `nvim-tree/nvim-tree.lua` | File explorer sidebar (toggle with `<Space>e`) |
| `nvim-telescope/telescope.nvim` | Fuzzy finder for files, grep, buffers, help, etc. |
| `nvim-telescope/telescope-fzf-native.nvim` | Native FZF sorter — much faster matching |
| `nvim-telescope/telescope-file-browser.nvim` | File browser extension for telescope |
| `nvim-treesitter/nvim-treesitter` | Syntax parsing for accurate highlighting and indentation |
| `akinsho/toggleterm.nvim` | Terminal inside Neovim (horizontal split at bottom) |
| `windwp/nvim-autopairs` | Auto-closes brackets, quotes, parens |
| `numToStr/Comment.nvim` | Smart code commenting (`gcc`, `gc` in visual) |
| `kylechui/nvim-surround` | Add/change/delete surrounding characters (`ys`, `cs`, `ds`) |

### LSP + Completion

| Plugin | Purpose |
|--------|---------|
| `neovim/nvim-lspconfig` | Language server configurations (Neovim 0.11 native API) |
| `williamboman/mason.nvim` | LSP/formatter/linter installer UI (`:Mason`) |
| `williamboman/mason-lspconfig.nvim` | Bridge between mason and lspconfig |
| `hrsh7th/nvim-cmp` | Completion engine |
| `hrsh7th/cmp-nvim-lsp` | LSP completion source |
| `hrsh7th/cmp-buffer` | Buffer word completion source |
| `hrsh7th/cmp-path` | File path completion source |
| `L3MON4D3/LuaSnip` | Snippet engine |
| `saadparwaiz1/cmp_luasnip` | LuaSnip completion source |
| `rafamadriz/friendly-snippets` | Pre-built snippet collection for many languages |
| `folke/neodev.nvim` | Neovim API type hints for Lua LSP |

### Git

| Plugin | Purpose |
|--------|---------|
| `lewis6991/gitsigns.nvim` | Inline git change indicators in the gutter |
| `tpope/vim-fugitive` | Git commands inside Neovim (`:Git`, `:Gdiff`, etc.) |

### AI

| Plugin | Purpose |
|--------|---------|
| `coder/claudecode.nvim` | Embeds Claude Code CLI inside Neovim as a side pane |
| `yetone/avante.nvim` | Cursor-style inline AI assistant (chat, explain, refactor) |

### Learning

| Plugin | Purpose |
|--------|---------|
| `folke/which-key.nvim` | Shows available keybindings when you pause after `<Space>` (v3 API) |
| `m4xshen/hardtime.nvim` | Restricts repeated `hjkl` spam; arrow keys are allowed |
| `ThePrimeagen/vim-be-good` | Interactive vim motion training games (`:VimBeGood`) |

---

## Keybindings Reference

**Leader key = `<Space>`**

### File & Navigation

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file tree (nvim-tree) |
| `<Space>ff` | Find files (telescope) |
| `<Space>fg` | Live grep — search text in project |
| `<Space>fb` | Open buffers list |
| `<Space>fr` | Recent files |
| `<Space>fh` | Search Neovim help docs |
| `<Space>w` | Save file |
| `<Space>q` | Quit |
| `<Space>bd` | Close current buffer |
| `<Space>/` | Clear search highlight |
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |

### Window Management

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |
| `<C-Up>` | Increase window height |
| `<C-Down>` | Decrease window height |
| `<C-Left>` | Decrease window width |
| `<C-Right>` | Increase window width |

### Terminal

| Key | Action |
|-----|--------|
| `<C-\>` | Toggle terminal (horizontal split) |
| `<Esc>` | Exit terminal mode back to normal mode |

### LSP (active when a language server is attached)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Show all references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code action (quick fixes, imports, etc.) |
| `<Space>D` | Go to type definition |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<Space>dl` | Show diagnostic in floating window |

### Completion (in insert mode)

| Key | Action |
|-----|--------|
| `<C-Space>` | Trigger completion manually |
| `<C-j>` | Select next item |
| `<C-k>` | Select previous item |
| `<CR>` | Confirm selection |
| `<C-e>` | Cancel completion |
| `<Tab>` | Next item / expand snippet |
| `<S-Tab>` | Previous item / jump back in snippet |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |

### Git

| Key | Action |
|-----|--------|
| `<Space>gs` | Git status (fugitive) |
| `<Space>gc` | Git commit |
| `<Space>gp` | Git push |
| `<Space>gl` | Git log |
| `]c` | Next git hunk (change) |
| `[c` | Previous git hunk |
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk |
| `<Space>hb` | Blame current line |
| `<Space>hd` | Diff this file |

### AI

| Key | Action |
|-----|--------|
| `<Space>cc` | Toggle Claude Code pane |
| `<Space>cs` | Send selection to Claude (visual mode) |
| `<Space>cf` | Focus Claude Code pane |
| `<Space>aa` | Open Avante AI chat |
| `<Space>ae` | Avante: explain selected code |
| `<Space>ar` | Avante: refactor selected code |

### Surround (nvim-surround)

| Key | Action | Example |
|-----|--------|---------|
| `ysiw"` | Surround word with `"` | `hello` → `"hello"` |
| `yss(` | Surround line with `()` | |
| `ds"` | Delete surrounding `"` | `"hello"` → `hello` |
| `cs"'` | Change `"` to `'` | `"hello"` → `'hello'` |
| `ysiw}` | Surround word with `{}` | `hello` → `{hello}` |

### Comments (Comment.nvim)

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` + motion | Comment a motion (e.g. `gcap` = comment paragraph) |
| `gc` in visual | Toggle comment on selection |

### Telescope Inside Picker

| Key | Action |
|-----|--------|
| `<C-j>` | Move down in results |
| `<C-k>` | Move up in results |
| `<C-p>` | Toggle preview pane |
| `<C-q>` | Send results to quickfix list |
| `<Esc>` | Close telescope |

### Vim Motions (Essential)

| Key | Action |
|-----|--------|
| `w` / `b` | Next / previous word |
| `e` | End of word |
| `0` / `$` | Line start / end |
| `gg` / `G` | File top / bottom |
| `{` / `}` | Prev / next paragraph |
| `<C-d>` / `<C-u>` | Half page down / up |
| `*` / `#` | Search word under cursor forward / backward |
| `f{char}` | Jump to char on line |
| `ci"` | Change inside quotes |
| `ci(` | Change inside parentheses |
| `ciw` | Change inside word |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |
| `jk` | Exit insert mode (custom) |

---

## LSP — Language Servers

Uses Neovim 0.11's native `vim.lsp.config()` + `vim.lsp.enable()` API (not the deprecated `require("lspconfig").server.setup()` approach).

### Pre-installed Servers

| Server | Language | Binary |
|--------|----------|--------|
| `lua_ls` | Lua | `lua-language-server` |
| `pyright` | Python | `pyright` |
| `ts_ls` | TypeScript / JavaScript | `typescript-language-server` |

### Adding More Servers

1. Open `:Mason`
2. Find the server, press `i` to install
3. Add to `lua/plugins/lsp.lua` in the `servers` table:
```lua
local servers = {
  lua_ls = { ... },
  pyright = {},
  ts_ls = {},
  rust_analyzer = {},   -- add new ones here
}
```

### How LSP Attach Works

LSP keymaps are registered via `LspAttach` autocmd — they only become active when a language server attaches to the current buffer. You'll know it's active when `K` shows hover docs.

---

## AI Integration

### Claude Code (`<Space>cc`)

Opens the Claude Code CLI as a side pane inside Neovim.

**Requirements:**
```bash
npm install -g @anthropic-ai/claude-code
claude  # run once to authenticate
```

**Usage:**
- `<Space>cc` — toggle the pane open/closed
- `<Space>cs` — send visual selection to Claude
- `<Space>cf` — focus the Claude pane

### Avante (Cursor-style inline AI)

Avante gives you a Cursor-like experience — ask questions, get inline diffs, explain/refactor code.

**Requirements:**
- `ANTHROPIC_API_KEY` must be set in your shell:
```bash
export ANTHROPIC_API_KEY="sk-ant-..."
# Add to ~/.zshrc or ~/.bashrc
```

**Configuration** (`lua/plugins/ai.lua`):
```lua
providers = {
  claude = {
    model = "claude-sonnet-4-5",
    extra_request_body = {
      temperature = 0,
      max_tokens = 4096,
    },
  },
},
```

**Usage:**
- `<Space>aa` — open AI chat sidebar
- `<Space>ae` — explain selected code
- `<Space>ar` — refactor selected code

---

## Learning Tools

### which-key

Press `<Space>` and **wait 1 second** — a popup shows all available leader keybindings. This is your cheat sheet while relearning.

### hardtime.nvim

Automatically enabled. It will:
- Restrict repeated `hjkl` spam (nudges you toward proper motions)
- **Arrow keys are enabled** — use them freely while getting comfortable
- Suggest better alternatives when you use inefficient patterns
- Gets out of your way once you build muscle memory

To disable temporarily: `:Hardtime disable`

When you're ready to go full vim-native, remove the `restricted_keys` override in `lua/plugins/learning.lua` — arrow keys will then be blocked as a final training step.

### vim-be-good

Run `:VimBeGood` for interactive motion training games. Recommended modes:
- `relative` — practice jumping with line numbers
- `ci{` — practice change-inside motions
- `word` — practice word navigation

---

## Telescope — Fuzzy Finder

Telescope is your primary navigation tool. Think of it as a command palette for everything.

### Layout

- **Wide terminal (>120 cols):** horizontal — results left, preview right (55%)
- **Narrow terminal:** vertical — results top, preview bottom

### Pickers

| Command | Key | What it finds |
|---------|-----|---------------|
| `find_files` | `<Space>ff` | All files (including dotfiles) |
| `live_grep` | `<Space>fg` | Text content across all files |
| `buffers` | `<Space>fb` | Open buffers, sorted by last used |
| `oldfiles` | `<Space>fr` | Recently opened files |
| `help_tags` | `<Space>fh` | Neovim help docs with preview |

### Tips
- Type part of any filename or text — it fuzzy-matches
- `<C-p>` to toggle preview on/off
- `<C-q>` to dump results into the quickfix list for batch operations

---

## Terminal

Uses `toggleterm.nvim` — a proper terminal manager inside Neovim.

- `<C-\>` — toggle a horizontal terminal at the bottom
- `<Esc>` — go back to normal mode from terminal
- Multiple terminals: `:ToggleTerm 2` opens a second terminal

---

## Git Integration

### gitsigns (inline)

Shows git changes in the sign column (left gutter):
- `│` green — added lines
- `│` red — removed lines
- `│` yellow — changed lines

| Key | Action |
|-----|--------|
| `]c` | Jump to next change |
| `[c` | Jump to previous change |
| `<Space>hs` | Stage the hunk under cursor |
| `<Space>hr` | Reset the hunk under cursor |
| `<Space>hb` | Blame annotation for current line |

### vim-fugitive (full git)

| Key / Command | Action |
|--------------|--------|
| `<Space>gs` | `:Git` — status overview |
| `<Space>gc` | `:Git commit` |
| `<Space>gp` | `:Git push` |
| `<Space>gl` | `:Git log` |
| `:Gdiff` | Side-by-side diff view |
| `:Gread` | Reset file to HEAD |
| `:Gwrite` | Stage current file |

---

## Troubleshooting

### Plugin errors on startup

```bash
# Check for errors
nvim --headless '+qa' 2>&1

# Sync all plugins
nvim --headless '+Lazy! sync' +qa
```

### LSP not attaching

1. Check `:Mason` — is the server installed?
2. Check `:checkhealth vim.lsp`
3. Make sure you're in the right filetype (`:set ft?`)

### Treesitter errors

```
:TSUpdate
```

If still broken, reinstall a specific parser:
```
:TSInstall lua
```

### Avante not working

Make sure your API key is exported:
```bash
echo $ANTHROPIC_API_KEY
# if empty:
export ANTHROPIC_API_KEY="sk-ant-..."
```

### Claude Code not working

```bash
# Make sure claude CLI is installed and authenticated
which claude
claude --version
claude  # run interactively to login
```

### Reset everything

```bash
rm -rf ~/.local/share/nvim/lazy   # delete all plugins
rm -rf ~/.local/share/nvim/mason  # delete all LSP servers
nvim  # reinstalls everything from scratch
```

---

## Key Design Decisions

| Decision | Reason |
|----------|--------|
| `lazy.nvim` as plugin manager | Standard, fast, great UI |
| Neovim 0.11 native LSP API | `require("lspconfig")` is deprecated — using `vim.lsp.config()` / `vim.lsp.enable()` |
| nvim-treesitter v2 | Neovim 0.11 ships treesitter built-in; v2 aligns with it |
| `treesitter = false` in telescope preview | treesitter v2 removed `ft_to_lang` which telescope uses; native syntax used instead |
| Catppuccin Mocha | Best plugin integration, transparent support, best looking dark theme in 2026 |
| `jk` to exit insert mode | Faster than reaching for Escape; zero conflict with normal typing |
| LSP keymaps via `LspAttach` | Only active when LSP is running; cleaner than global registration |
| Avante `providers.claude` | Avante v2 moved provider config out of top-level — fixes deprecation warning |
| which-key `win` not `window` | which-key v3 renamed the popup window config key — `window` caused deprecation warning |
| which-key `wk.add()` not `wk.register()` | which-key v3 replaced `register()` with `add()` using `group =` spec format |
| hardtime arrow keys allowed | `restricted_keys` override keeps arrow keys working while learning vim motions |
| lualine theme `"auto"` | `"catppuccin"` is not a standalone lualine theme — `auto` detects active colorscheme |

---

*Config built and maintained for Neovim 0.11.6 on macOS (Apple Silicon)*
