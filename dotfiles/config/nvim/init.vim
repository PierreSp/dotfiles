set spell spelllang=en_us
set undofile
set encoding=utf-8

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

set ignorecase
set number
set conceallevel=1
set termguicolors
set background=dark

set expandtab
set autoindent
set softtabstop=4
set shiftwidth=2
set tabstop=4

set history=1000

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

autocmd BufEnter * lcd %:p:h

filetype plugin indent on

set undodir=~/.config/nvim/undodir

call plug#begin()
Plug 'KeitaNakamura/neodark.vim' " Colorscheme
Plug 'vim-scripts/Vimball' " vim plugin archive manager
Plug 'godlygeek/tabular' " beautiful vim aliger https://devhints.io/tabular
Plug 'scrooloose/nerdtree' 
Plug 'tpope/vim-fugitive' " Github manager
Plug 'itchyny/lightline.vim' " simple powerline (could be replaced
Plug 'ctrlpvim/ctrlp.vim' " fast path vinder
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/nginx.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'SirVer/ultisnips' " Snippet manager
Plug 'honza/vim-snippets' " Add snippets to engine
Plug 'vim-syntastic/syntastic' " Syntax checker
Plug 'sheerun/vim-polyglot' " Syntax manager
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround' " Replace brackets, ...
Plug 'airblade/vim-gitgutter'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Raimondi/delimitMate' " auto closing of quotes, brackets,...Quramy/tsuquyomi
Plug 'tmhedberg/SimpylFold'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/nginx.vim'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi' "Typescript advancements
Plug 'Shougo/vimproc.vim', {'do' : 'make'} " Exectue withhin vim

call plug#end()

" Always start deoplete
let g:deoplete#enable_at_startup = 1

" Colorscheme
colorscheme neodark
let g:neodark#background = '#202020'
let g:lightline = {}
let g:lightline.colorscheme = 'neodark'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Javascript options
let g:javascript_plugin_jsdoc           = 1
let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_arrow_function = "⇒"
let g:javascript_conceal_return         = "⇚"

let g:jsx_ext_required = 0

" Check syntex when file is opened
let g:syntastic_check_on_open=1

" Nerd Tree mappings
map <C-E> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']

let g:ycm_autoclose_preview_window_after_completion=1

"Set folding
set foldmethod=indent
set foldlevel=99

"Nginx options
au BufRead,BufNewFile *.nginx set ft=nginx
au BufRead,BufNewFile */etc/nginx/* set ft=nginx
au BufRead,BufNewFile */usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx

set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
