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
set mousehide

" Permanent undo
set undodir=~/.vimdid
set undofile

" Better wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor


" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

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
Plug 'tpope/vim-surround'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Plug 'rust-lang/rust.vim'
Plug 'rakr/vim-one'
Plug 'honza/vim-snippets'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'dag/vim-fish'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'cespare/vim-toml'
Plug 'alerque/vim-commonmark', {'do': 'make'}
Plug 'ayu-theme/ayu-vim'

call plug#end()

autocmd bufread,bufnewfile  *.md set filetype=markdown
autocmd bufread,bufnewfile  *.rs set filetype=rust
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

" Required for operations modifying multiple buffers like rename.
set hidden

" Completion
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

set statusline+=%#warningmsg#
set statusline+=%*
set cursorline

colorscheme ayu
set background=dark
let ayucolor="mirage"

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

" gutentags settings
" let g:gutentags_ctags_tagfile=".tags"

" =====================================================================
" COC.vim config
" =====================================================================

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make syntax highlighting more efficient.
syntax sync fromstart

" 'recommended style' uses 99-column lines. No thanks.
let g:rust_recommended_style = 0

" Always run rustfmt is applicable and always use stable.
let g:rustfmt_autosave_if_config_present = 1
let g:rustfmt_command = "rustfmt +stable"

" Make CTRL-T work correctly with goto-definition.
" setlocal tagfunc=CocTagFunc

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-jefinition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gre <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" simpler format keybinding
nmap <leader>ht :Format<cr>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" commonmark syntax extensions
let g:commonmark#extentions#all = 1
