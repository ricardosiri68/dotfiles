set clipboard=unnamedplus
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Keep Plugin commands between vundle#begin/end.
Plugin 'MarcWeber/vim-addon-mw-utils'

" Fugitive
Plugin 'tpope/vim-fugitive'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Snipmate
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Optional:
Plugin 'honza/vim-snippets'

" vim syntastic
Plugin 'vim-syntastic/syntastic'

" UNITE dependencies
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/neoyank.vim'

" *.vue file plugin
Plugin 'posva/vim-vue'

" javascript and react
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" Wakatime
Plugin 'wakatime/vim-wakatime'

" Emmet
Plugin 'mattn/emmet-vim'

" Blade (laravel template language)

Plugin 'jwalton512/vim-blade'

" Nova Theme
Plugin 'trevordmiller/nova-vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" main config

"set term=xterm-256color
"set t_Co=256
let mapleader=" " " mapea la tecla lider para que sea la barra espaciadora
set number " mustra la columna con el numero de linea
set noswapfile " no genera archivos *.swp
set nowrap

set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233
noremap <F5> <Esc>:syntax sync fromstart<CR> " refresca el resaltado de sintaxis

set modeline " tiene algo que ver con el identado pero no se realmente de que va

" solarizez theme
syntax enable
" set background=dark
" colorscheme solarized
colorscheme nova

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" PHP checkers
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=vendor/pragmarx/laravelcs/Standards/Laravel'                            

" Python checkers
let g:syntastic_python_checkers = ['flake8', 'pylint']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

silent! nmap <F6> :SyntasticToggleMode<CR>

" UNITE.vim plugin
" encontrar un patron en los direcotrios
set ignorecase
let g:unite_source_grep_command="ag"
let g:unite_source_grep_default_opts="-i --nocolor --nogroup"
let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '']
call unite#filters#matcher_default#use(['matcher_fuzzy'])

nnoremap <space>/ :Unite grep:.<cr>

" reemplaza a ctrlp
nnoremap <C-p> :Unite -start-insert file_rec/async<cr>

" moviendonos en el historial del yank
nnoremap <space>y :Unite history/yank<cr>

" moviendonos por la lista de buffers
nnoremap <space>s :Unite -quick-match buffer<cr>

" BLADE 
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }
" WINDOWS/BUFFERS movements 
" next and previous buffer
nnoremap <C-n> :bn<cr>
nnoremap <C-b> :bp<cr>
" jump split
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" avoiden CTRL-c canselation
imap <C-c> <nop>
map <C-c> <nop>
vmap <C-c> <nop>

" PYTHN BINDINGS
map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

" Emme
autocmd FileType html,css,js EmmetInstall
