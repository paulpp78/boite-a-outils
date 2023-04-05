nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>g :GitGutterToggle<CR>
nnoremap <Leader>c :call CompileCode()<CR>
nnoremap <Leader>b :Build<CR>

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set mouse=a

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
call plug#end()
filetype plugin indent on

function! CompileCode()
  if &filetype == 'c'
    exec '!gcc % -o %<'
  elseif &filetype == 'cpp'
    exec '!g++ % -o %<'
  elseif &filetype == 'java'
    exec '!javac %'
  elseif &filetype == 'python'
    exec '!python -m py_compile %'
  else
    echo 'Cannot compile this file type'
  endif
endfunction

function! Build()
  exec '!make'
endfunction

function! GitAutoCommit()
  let message = input("Commit message: ")
  exec ':silent !git add %'
  exec ':silent !git commit -m "'. message .'"'
endfunction
augroup GitAutoCommit
  autocmd!
  autocmd BufWritePost * call GitAutoCommit()
augroup END

colorscheme gruvbox

autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2

set nowrap
set noswapfile
set undodir=~/.vim/undodir
set undofile
set incsearch
set hlsearch
set lazyredraw
set scrolloff=3
set backspace=indent,eol,start
set relativenumber
set noerrorbells
set visualbell
set ttimeoutlen=1000
set encoding=utf-8
set hidden
set noshowmode
set laststatus=2
set cmdheight=2
set updatetime=300
set formatoptions-=cro
set nobackup
set nowritebackup
set completeopt=menuone,noselect
set clipboard=unnamedplus
set guifont=FiraCode\ Nerd\ Font\ Mono:h14