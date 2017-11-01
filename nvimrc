" Scripts-----------------------------

set clipboard=unnamedplus
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/smoke/.config/nvim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/smoke/.config/nvim/bundle')
  call dein#begin('/home/smoke/.config/nvim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/home/smoke/.config/nvim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " FUGITIVE
  call dein#add('tpope/vim-fugitive')

  " SYNTASTIC
  call dein#add('vim-syntastic/syntastic')

  " WAKATIME
  call dein#add('wakatime/vim-wakatime')

  " EMMET
  call dein#add('mattn/emmet-vim')

  " NOVA THEME
  call dein#add('trevordmiller/nova-vim')

  " DENITE
  call dein#add('Shougo/denite.nvim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" End dein Scripts-------------------------

colorscheme nova
set termguicolors

let mapleader=" " " mapea la tecla lider para que sea la barra espaciadora
set number " mustra la columna con el numero de linea
set noswapfile " no genera archivos *.swp
set nowrap

set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn guibg=#444444
noremap <F5> <Esc>:syntax sync fromstart<CR> " refresca el resaltado de sintaxis

set modeline " tiene algo que ver con el identado pero no se realmente de que va

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

" DENITE
set ignorecase
"let g:unite_source_grep_command="ag"
"let g:unite_source_grep_default_opts="-i --nocolor --nogroup"
" call unite#filters#matcher_default#use(['matcher_fuzzy'])

call denite#custom#var('file_rec', 'command',                                                                                                  
        \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])


" seleccionar buffer
nnoremap <leader>s :Denite -mode=normal buffer<cr>

" buscar un archivo
nnoremap <C-p> :Denite -auto-resume -mode=normal file_rec<cr>

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

" HELP NAVIGATION
nnoremap <F8> <C-T>
nnoremap <F9> <C-]>
