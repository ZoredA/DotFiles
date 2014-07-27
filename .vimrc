" autocmd!
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()
filetype plugin indent on
" Taken from https://github.com/scrooloose/nerdtree
autocmd vimenter * if !argc() | NERDTree | endif

" Taken from http://www.vim.org/scripts/script.php?script_id=3465
nmap <F3> :TagbarToggle<CR> 

" http://stevelosh.com/blog/2010/09/coming-home-to-vim
set nocompatible
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2

let mapleader = ","
nnoremap / /\v
vnoremap / /\v
set gdefault
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1

nnoremap j gj
nnoremap k gk
" Gets rid of the annoying help key.
" inoremap <F1> <ESC>
" nnoremap <F1> <ESC>
" vnoremap <F1> <ESC>
nnoremap ; :
au FocusLost * :wa

" Leader commands.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>a :Ack
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
nnoremap <leader>q gqip
nnoremap <leader>v V`]

" Vertical Window Commands. 
" Opens a Vertical Window.
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Faster escaping
inoremap jj <ESC>


" Vim 7.3 + only I am afraid. :(
" set relativenumber
" set undofile
" set colorcolumn=85

:nnoremap <F8> :setl noai nocin nosi inde=<CR>
:noremap <F1> :tabn<CR>
:noremap <F2> :tabp<CR>
:inoremap <S-Tab> <C-V><Tab>
:set number
:set smartcase ignorecase incsearch
:set tabstop=4 shiftwidth=4 expandtab
:set softtabstop=4

" Ctrl-j/k deletes blank line below/above, and Alt-j/k inserts.
" http://vim.wikia.com/wiki/Quickly_adding_and_deleting_empty_lines
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

unlet! b:isCPP

augroup CPP
    autocmd!
    " Taken from http://learnvimscriptthehardway.stevelosh.com/chapters/13.html
    autocmd FileType cpp :iabbrev <buffer> iff if ()<left>
    :autocmd FileType cpp let b:isCPP = 1
augroup END

augroup CHeader
    autocmd!
    :if exists("b:isCPP")
        " Taken from http://www.thegeekstuff.com/2008/12/vi-and-vim-autocommand-3-steps-to-add-custom-header-to-your-file/
        autocmd bufnewfile so /home/zbahmer/Templates/cpp_header.txt
        autocmd bufnewfile exe "1," . 7 . "g/File Name :.*/s//File Name : " .expand("%")
        autocmd bufnewfile exe "1," . 7 . "g/Creation Date :.*/s//Creation Date : " .strftime("%d-%m-%Y")
        autocmd Bufwritepre,filewritepre execute "normal ma"
        autocmd Bufwritepre,filewritepre execute "1," . 7 . "g/Last Modified :.*/s//Last Modified : " .strftime("%c")
        autocmd bufwritepost,filewritepost execute "normal `a"
        autocmd bufnewfile *.h execute "normal G"
        autocmd bufnewfile *.h so /home/zbahmer/Templates/header_header.txt
        autocmd bufnewfile *.h exe "11,". 13 . "g/GUARD_/s//__" .toupper( substitute( expand("%"), '\.', '\\_', 'g' ) ). "_INCLUDED__"
        autocmd bufnewfile *.h exe "normal j"
    endif
augroup END
