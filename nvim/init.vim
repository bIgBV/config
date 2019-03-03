syntax on
let g:dotvim = fnamemodify($MYVIMRC, ':h')
" autocmd vimenter * NERDTree
set shiftwidth=4
set tabstop=4
set expandtab
set smartindent
set laststatus=2
" set t_Co=256
set termguicolors
" set background=dark
set nocompatible
" Setting scrolloff to large number
" results in cursor centered vertically when possible
" set scrolloff=999
set synmaxcol=200
" Automatically write files when changing files
set autowrite
set hidden
" Show command at bottom right
set showcmd
" More line height
set linespace=3
set go-=T
" Better wrapping
set wrap
set textwidth=79
set formatoptions=qrn1
" Enable code folding
" set foldmethod=syntax
set mousehide
set wildmenu
" Set encoding
"set encoding=utf8
set nu
" stop vim from hiding markdown symbols
set conceallevel=0

" filetype off

call plug#begin('~/.vim/plugged')

" installing plugins
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'easymotion/vim-easymotion'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
" Plug 'Yggdroot/indentLine'
Plug 'ludovicchabant/vim-gutentags'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'zchee/deoplete-clang'
" Plug 'mhartington/nvim-typescript'
" Plug 'leafgarland/typescript-vim'
Plug 'zchee/deoplete-jedi'
Plug 'rakr/vim-one'
" Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'honza/vim-snippets'
Plug 'vim-pandoc/vim-pandoc-syntax'
" Language client for LSP
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'dag/vim-fish'

call plug#end()

autocmd bufread,bufnewfile  *.md set filetype=markdown
autocmd bufread,bufnewfile  *.rs set filetype=rust
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

let g:deoplete#sources#clang#libclang_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/6.0.0/lib/clang/'
let g:deoplete#enable_at_startup = 1

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
set completeopt-=preview

" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_command = "rustfmt"
"let g:rustfmt_options = "--emit files"
let g:rustfmt_emit_files = 1
let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 0

" Completion
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

set statusline+=%#warningmsg#
set statusline+=%*
set cursorline

colorscheme gruvbox
set background=dark

" ALE options
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='one'
set statusline+=%*
set cursorline

" ALE options
nmap <silent> <C-l> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <leader>af :ALEFix<CR>


" Neomake: When writing a buffer.
" call neomake#configure#automake('w')

let g:ale_linters = {'rust': ['rls'], 'python': ['flake8']}
let g:ale_fixers = {
            \ '*': ['remove_trailing_lines', 'trim_whitespace'],
            \ 'python': ['yapf'],
            \ 'C++': ['clang-format'],
            \ 'c': ['clang-format'],
            \ '*.h': ['clang-format'] ,
            \ 'rust': ['rustfmt']}

let g:ale_python_flake8_executable = 'python2'
let g:ale_python_flake8_args = '--ignore=E501'

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1


filetype plugin indent on

" Map leader key to space
let mapleader = " "

" Bubble single lines
nmap <C-J> ddp
nmap <C-K> ddkkp
" Bubble selections
vmap <C-J> :move '>+1<CR><Esc>gv
vmap <C-K> :move '<-2<CR><Esc>gv

" Enter insert mode with a line above and below
nmap <leader>i: o<ESC>O

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" noremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>, :NERDTreeFind<CR>
nnoremap <leader>\ :noh<CR>
nnoremap <leader>gs :Gst<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <leader>lo :lopen<CR>
vnoremap // y/\V<C-R>"<CR>

" Map escape to jk
imap jk <Esc>


" Fzf Find command
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case  --hidden --follow --color "always" '.shellescape(<q-args>), 1, <bang>0)
let $FZF_DEFAULT_COMMAND = 'rg --files --follow'

" Set default source to ripgrep
let $FZF_DEFAULT_COMMAND = 'rg --files --follow'

nnoremap <leader>ff :Files<CR>
nnoremap <leader>fs :Find
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fj :BTags<CR>

highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" vimwiki settings
let g:vimwiki_list=[{'syntax': 'markdown', 'ext': '.md'}]
let g:tex_flavor='latex'

