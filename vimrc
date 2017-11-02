" GENERAL INITAL CONFIG
"------------------------------------------------------------------------------------------------------------------------
set clipboard=unnamedplus
let mapleader=" " " mapea la tecla lider para que sea la barra espaciadora


" DEIN (Package Manager)
"------------------------------------------------------------------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
"
" Required:
set runtimepath+=/home/smoke/.vim/dein_bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/smoke/.vim/dein_bundle/')
  call dein#begin('/home/smoke/.vim/dein_bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/home/smoke/.vim/dein_bundle/repos/github.com/Shougo/dein.vim')
  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  "
  " Add or remove your plugins here:

  " FUGITIVE
  call dein#add('tpope/vim-fugitive')

  " SYNTASTIC
  call dein#add('vim-syntastic/syntastic')

  " WAKATIME
  call dein#add('wakatime/vim-wakatime')

  " EMMET
  call dein#add('mattn/emmet-vim')

  " DENITE
  call dein#add('Shougo/denite.nvim')

  " Required:
  call dein#end()
  call dein#save_state()
endif
"
" Required:
filetype plugin indent on
syntax enable


" COLOR AND THEME (solarized theme)
"------------------------------------------------------------------------------------------------------------------------

" 256 colors
set term=xterm-256color
set t_Co=256

set number " mustra la columna con el numero de linea
set noswapfile " no genera archivos *.swp
set nowrap

set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233 guibg=#444444
noremap <F5> <Esc>:syntax sync fromstart<CR> " refresca el resaltado de sintaxis

set modeline " tiene algo que ver con el identado pero no se realmente de que va

set background=dark
colorscheme solarized


" SYNTASTIC
"------------------------------------------------------------------------------------------------------------------------
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
" ------------------------------------------------------------------------------------------------------------------------
set ignorecase
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" call unite#filters#matcher_default#use(['matcher_fuzzy'])

call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])

" seleccionar buffer
nnoremap <leader>s :Denite -mode=normal buffer<cr>

" buscar un archivo
nnoremap <C-p> :Denite -mode=normal file_rec<cr>

" buscar en el contenido de un archivo (ag)
nnoremap <leader>/ :Denite -mode=normal grep line<cr>

" moviendonos en el historial del yank
" nnoremap <space>y :Unite history/yank<cr>
nnoremap <leader>y :Denite -mode=normal register<cr>


" WINDOWS/BUFFERS movements 
"------------------------------------------------------------------------------------------------------------------------
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
"------------------------------------------------------------------------------------------------------------------------
" IPDB breakpoints
map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>


" EMMET
"------------------------------------------------------------------------------------------------------------------------
autocmd FileType html,css,js EmmetInstall


" STATUS LINE
"------------------------------------------------------------------------------------------------------------------------
set statusline="%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]"
set laststatus=2


" HELP NAVIGATION
"------------------------------------------------------------------------------------------------------------------------
nnoremap <F8> <C-T>
nnoremap <F9> <C-]>
