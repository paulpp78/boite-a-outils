" Toggle NERDTree with <Leader>n
nnoremap <Leader>n :NERDTreeToggle<CR>

" Toggle GitGutter with <Leader>g
nnoremap <Leader>g :GitGutterToggle<CR>

" Compile code with <Leader>c
nnoremap <Leader>c :call CompileCode()<CR>

" Run make with <Leader>b
nnoremap <Leader>b :Build<CR>

" Set tabstop to 4 and shiftwidth to 5, expand tabs to spaces, autoindent, smartindent, and enable mouse
set tabstop=4
set shiftwidth=5
set expandtab
set autoindent
set smartindent
set mouse=a

" Use Plug for managing plugins, and install the following plugins
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
call plug#end()
filetype plugin indent on

" Compile code for different filetypes
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

" Run make
function! Build()
  exec '!make'
endfunction

" Automatically add and commit changes to Git
function! GitAutoCommit()
  let message = input("Commit message: ")
  exec ':silent !git add %'
  exec ':silent !git commit -m "'. message .'"'
endfunction
augroup GitAutoCommit
  autocmd!
  autocmd BufWritePost * call GitAutoCommit()
augroup END

" Set the gruvbox color scheme
colorscheme gruvbox

" Set options for different filetypes
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 autoindent smartindent
autocmd FileType javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 autoindent smartindent
autocmd FileType html setlocal shiftwidth=2 tabstop=2 expandtab softtabstop=2 autoindent smartindent

" Disable line wrap, swap files, and enable persistent undo
set nowrap
set noswapfile
set undodir=~/.vim/undodir
set undofile

" Set incremental and highlight search, lazy redraw, scrolloff, and backspacing options
set incsearch
set hlsearch
set lazyredraw
set scrolloff=3
set backspace=indent,eol,start

" Show line numbers, disable error bells, use visual bell, and set timeout for escape key
set relativenumber
set noerrorbells
set visualbell
set ttimeoutlen=1000

" Set encoding and hide buffers when abandoned
set encoding=utf-8
set hidden

" Hide default mode text, always display status line, and increase command-line height
set noshowmode
set laststatus=2
set cmdheight=2

" Set update interval for gitsigns, stop newline continuation of comments, and disable backup files
set updatetime=300
set formatoptions-=cro
set nobackup " This is recommended by coc
set nowritebackup " Do not write a backup file, use versions instead.
set completeopt=menuone,noselect " Set completeopt to have a better completion experience
set clipboard=unnamedplus " Copy to system clipboard on yank and paste from system clipboard on paste (vim 7.4.52+)
set guifont=FiraCode\ Nerd\ Font\ Mono:h14  " Set font for GUI version of Vim (MacVim, gVim, etc.)