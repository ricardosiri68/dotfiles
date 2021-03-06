" GENERAL INITAL CONFIG
"------------------------------------------------------------------------------------------------------------------------
scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8
set clipboard=unnamedplus
let mapleader=" " " mapea la tecla lider para que sea la barra espaciadora
set ff=unix


" DEIN (Package Manager)
"------------------------------------------------------------------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
"
" Required:
set runtimepath+=~/.vim/dein_bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein_bundle/')
  call dein#begin('~/.vim/dein_bundle')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein_bundle/repos/github.com/Shougo/dein.vim')
  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  "
  " Add or remove your plugins here:

  " Indexer
  call dein#add('vim-scripts/vimprj')
  call dein#add('vim-scripts/DfrankUtil')
  call dein#add('vim-scripts/indexer.tar.gz')

  " PHP Complete

  " TAGBAR
  call dein#add('majutsushi/tagbar')

  " BLADE
  call dein#add('jwalton512/vim-blade')

  " FUGITIVE
  call dein#add('tpope/vim-fugitive')

  " GITGUTTER
  call dein#add('airblade/vim-gitgutter')

  " SYNTASTIC
  call dein#add('vim-syntastic/syntastic')

  " WAKATIME
  call dein#add('wakatime/vim-wakatime')

  " EMMET
  call dein#add('mattn/emmet-vim')

  " DENITE
  call dein#add('Shougo/denite.nvim')

  " Track the engine.
  call dein#add('SirVer/ultisnips')

  " Snippets are separated from the engine. Add this if you want them:
  call dein#add('honza/vim-snippets')

  " TypeScript Syntax Highlighting
  call dein#add('leafgarland/typescript-vim')

  " Vue plugin
  call dein#add('posva/vim-vue')

  " LOG FILES
  call dein#add('dzeban/vim-log-syntax')

  call dein#add('echuraev/translate-shell.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif
"
" Required:
filetype plugin indent on
syntax enable


"
" TODO: buscando una manera de implementar la reprecentacion de los tabs de
" alguna manera
" IDENTATION REPECENTATION
"------------------------------------------------------------------------------------------------------------------------
" set whichwrap+=<,>,h,l,[,]
" set breakindent
" set listchars=eol:↲,nbsp:_,trail:•,extends:⟩,precedes:⟨,tab:┆·,space:_

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
"let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers = ['php', 'phpmd']

" Python checkers
let g:syntastic_python_checkers = ['flake8', 'pylint']

" Typescript checkers
let g:syntastic_typescript_checkers = ['tslint', 'tsc']

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
call denite#custom#source('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])

call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g',  ''])

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



" EMMET
"------------------------------------------------------------------------------------------------------------------------
autocmd FileType html,css,js,ts EmmetInstall


" STATUS LINE
"------------------------------------------------------------------------------------------------------------------------
set statusline="%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]"
set laststatus=2


" FILETYPE BINDING
"------------------------------------------------------------------------------------------------------------------------
au! BufNewFile,BufRead *.jinja2 setf htmldjango


" HELP NAVIGATION
"------------------------------------------------------------------------------------------------------------------------
nnoremap <F8> <C-T>
nnoremap <F9> <C-]>

" REDRAW BUFFER
"------------------------------------------------------------------------------------------------------------------------
nnoremap <F3> :redraw!<CR>


" ULTISNIPS: a snippets tool
"------------------------------------------------------------------------------------------------------------------------

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" CTAGS CONTROL
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" NETRW
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_preview = 1
map <F2> :Ex .<CR>

" TAGBAR
let g:tagbar_width = 60
nmap <F3> :TagbarToggle<CR>

" FOLDING
map <C-f> zfa{

" GITGUTTER
map <F7> :GitGutterToggle

" PHP Complete
let g:phpcomplete_parse_docblock_comments = 1

" TRANS
let g:trans_history_file = '~/trans_history.csv'
let g:trans_save_history = 1
let g:trans_advanced_options = "-brief -e bing"
let g:trans_default_direction = ":pt+es"
vnoremap <silent> <leader>T :Trans -brief<CR>
