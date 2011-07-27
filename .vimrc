" This must be first, because it changes other options as side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" " plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" change the mapleader from \ to ,
let mapleader=","

"One particularly useful setting is hidden. Its name isn’t too descriptive,
"though. It hides buffers instead of closing them. This means that you can
"have unwritten changes to a file and open a new file using :e, without being
"forced to write or undo your changes first. Also, undo buffers and marks are
"preserved while the buffer is open. This is an absolute must-have.
set hidden

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start "allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set expandtab
set ruler
"set smartindent


set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

set pastetoggle=<F2>

:syn on

set list
set listchars=tab:»·
set listchars+=trail:·
set endofline

"set nocp
filetype plugin on

set t_Co=256
colorscheme mustang
"colorscheme desert

set mouse=a

nnoremap ; :
" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

cmap w!! w !sudo tee % >/dev/null

set showcmd

set tags+=~/.vim/tags/stl
set tags+=~/.vim/tags/boost
set tags+=~/.vim/tags/qt4_new
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/gl
"set tags+=./tags

let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
map <F5> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

