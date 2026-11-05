# nvim

Neovim config for someone who writes most code with an agent and the rest by
hand, as practice. The editor's job is therefore split: read and review what
Claude wrote, and get out of the way when I type.

Two rules shape every keymap:

- **One letter, one noun.** Everything about git is under `<leader>g`,
  everything about search under `<leader>s`. Press `<leader>` and wait;
  which-key lists the nouns.
- **Shift reverses.** `p` below / `P` above, `n` next / `N` previous,
  `u` undo / `U` redo, `J` down / `K` up, `f` forward / `F` back.

Lessons that teach this config, with practice inside the files:
`~/projects/drills/nvim/`.

## Layout

```
init.lua                  loads the three core files, then lazy.nvim
lua/core/options.lua      editor settings
lua/core/keymaps.lua      every keymap that is not tied to a plugin
lua/core/autocmds.lua
lua/plugins/*.lua         one file per concern; lazy.nvim merges them
```

Neovim 0.12, lazy.nvim, catppuccin. Mason installs the language servers on
first start.

## Keymaps by noun

`<leader>` is space.

| Prefix | Noun | Keys |
| --- | --- | --- |
| `a` | AI | `aa` toggle Claude · `ac` continue last session · `ar` pick a session · `af` focus · `ab` send buffer · `as` send selection (visual) · `ay` / `an` accept / reject diff |
| `b` | buffer | `bd` close, land on a file · `bD` close every hidden buffer |
| `c` | code | `ca` action · `cr` rename symbol · `cf` format |
| `d` | debug | DAP: `db` breakpoint · `dB` conditional · `dr` repl · `du` ui · `dx` stop |
| `e` | explorer | `e` toggle tree · `E` reveal this file |
| `f` | find | `ff` files · `fg` grep · `fb` buffers · `fr` recent · `fh` help |
| `g` | git | `gg` lazygit · `gv` diff view, all files · `go` overlay · `gd` diff this file · `gb` blame · `gl` / `gL` file / repo log · `ghs` `ghr` `ghp` `ghS` stage / reset / preview hunk, stage buffer |
| `s` | search | `sr` replace word or selection in file · `sw` word in project · `sf` fuzzy in file · `sp` project-wide search & replace |
| `x` | diagnostics | `xl` under cursor · `xx` this file · `xX` project |
| `y` | yank for the agent | `yf` relative path#line · `yp` absolute · `yc` selection as a code block with file and line |
| | | `w` save · `q` quit · `p` paste last yank · `/` clear highlight · `tm` toggle markdown rendering |

Not under leader:

| Key | Does |
| --- | --- |
| `H` / `L` | line start / end (visual: indent left / right) |
| `J` / `K` (visual) | move selection down / up |
| `x` | delete char without touching the clipboard |
| `p` (visual) | paste over, keep the clipboard |
| `U` | redo |
| `n` / `N` | next / previous match, centred |
| `gd` `gD` `gy` `gr` `gi` `K` | LSP: definition, declaration, type, references, implementation, hover |
| `]d` `[d` `]c` `[c` `]q` `[q` | next / previous diagnostic, change, quickfix item |
| `Tab` / `S-Tab` | next / previous buffer |
| `<C-h/j/k/l>` | move between windows; from a terminal `<C-h>` leaves it in one key |
| `<C-\>` | terminal |
| `jk` | escape (insert) |
| `<C-l>` / `<M-l>` (insert) | accept supermaven suggestion / one word |
| `Esc Esc` (terminal) | normal mode |

## Plugins

| Concern | Plugin |
| --- | --- |
| UI | catppuccin, lualine, noice + nvim-notify, rainbow-delimiters, render-markdown |
| Files | nvim-tree, telescope (+ fzf-native, file-browser), grug-far |
| Editing | treesitter, nvim-autopairs, nvim-surround, toggleterm, supermaven |
| Code | nvim-lspconfig, mason (+ lspconfig, tool-installer), nvim-cmp, conform, rustaceanvim, nvim-dap (+ ui, virtual-text), vim-cppman |
| Git | gitsigns, mini.diff, codediff, lazygit via toggleterm |
| AI | claudecode.nvim |
| Learning | which-key |

Deliberately absent: a chat plugin with its own API key (the agent runs in a
terminal and talks through claudecode.nvim), snippets, bufferline.

## Tools it expects

```
brew install neovim ripgrep fd lazygit git-delta
```

plus a Nerd Font, Node (Mason) and clang-format / ruff / rustfmt for conform.
`~/.config/lazygit/config.yml` points lazygit at delta.

## Review flow

After the agent has changed things: `<leader>gg` to see which files,
`<leader>gv` to read them side by side, `<leader>go` + `]c` inside one file,
`<leader>ghr` to drop a hunk, commit from lazygit. `<leader>bD` afterwards
sweeps the buffers it opened.
