" Fundamentals "{{{
" -------------------------------------------------------------------------

autocmd!
scriptencoding utf-8
if !1 | finish | endif

set number
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set modifiable
set buftype=
set clipboard=unnamedplus
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set title
set hlsearch
" set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab

set shell=bash
if has ('nvim')
	set inccommand=split
endif

filetype plugin indent on
set ai
set si
set nowrap
set backspace=start,eol,indent
set path+=**

set formatoptions+=r
set t_Co=256   " This is may or may not needed.

nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
" set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}


" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
" if has("unix")
"   let s:uname = system("uname -s")
"   " Do Mac stuff
"   if s:uname == "Darwin\n"
"     runtime ./macos.vim
"   endif
" endif

" runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" colorscheme PaperColor

"}}}

" Extras "{{{
" ---------------------------------------------------------------------
set exrc

"}}}



" map <F8> :TagbarToggle<CR>


