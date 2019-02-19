" GENERAL INITAL CONFIG
"------------------------------------------------------------------------------------------------------------------------
highlight ColorColumn ctermbg=233 guibg=#444444
set colorcolumn=80
set modeline " tiene algo que ver con el identado pero no se realmente de que va
set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set number " mustra la columna con el numero de linea
set noswapfile " no genera archivos *.swp
set nowrap
set clipboard+=unnamedplus
set nohlsearch
let mapleader=" " " mapea la tecla lider para que sea la barra espaciadora
filetype plugin indent on

" avoiden CTRL-c canselation
imap <C-c> <nop>
map <C-c> <nop>
vmap <C-c> <nop>

" VIMPLUG
"------------------------------------------------------------------------------------------------------------------------
" instala el gestor de plugins si aun no esta instalado descargandolo del
" repositorio, es un plugin de un un solo archivo vim que solo depende de que
" se encuentr curl instalado en el sistema
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

    Plug 'majutsushi/tagbar'
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-path'
    Plug 'neomake/neomake'
    Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
    Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
    Plug 'StanAngeloff/php.vim', {'for': 'php'}
    Plug 'w0rp/ale'
    Plug 'Shougo/denite.nvim'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'iCyMind/NeoSolarized'
    Plug 'mattn/emmet-vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'posva/vim-vue'
    Plug 'dzeban/vim-log-syntax'
    Plug 'echuraev/translate-shell.vim'
    Plug 'kshenoy/vim-signature'
    Plug 'jreybert/vimagit'
    Plug 'wakatime/vim-wakatime'

call plug#end()

" SNIPPETS
"------------------------------------------------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:ultisnips_php_scalar_types = 1

" GUTENTAGS
"------------------------------------------------------------------------------------------------------------------------
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
" let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" ALE
"------------------------------------------------------------------------------------------------------------------------
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
" let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 0


" AUTOCOMPLETION
"------------------------------------------------------------------------------------------------------------------------
augroup ncm2
  au!
  autocmd BufEnter * call ncm2#enable_for_buffer()
  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
  au User Ncm2PopupClose set completeopt=menuone
augroup END

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"


" DENITE
" ------------------------------------------------------------------------------------------------------------------------
set ignorecase
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '*~', '*.o', '*.exe', '*.bak',
      \ '.DS_Store', '*.pyc', '*.sw[po]', '*.class',
      \ '.hg/', '.git/', '.bzr/', '.svn/',
      \ 'node_modules/', 'bower_components/', 'tmp/', 'log/', 'vendor/ruby',
      \ '.idea/', 'dist/',
      \ 'tags', 'tags-*'])
call denite#custom#source('file/rec', 'matchers', ['matcher_fuzzy', 'matcher_project_files', 'matcher_ignore_globs'])

call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g',  ''])

" seleccionar buffer
nnoremap <leader>s :Denite -mode=normal buffer<cr>

" buscar un archivo
nnoremap <C-p> :Denite -mode=normal file/rec<cr>

" buscar en el contenido de un archivo (ag)
nnoremap <leader>/ :Denite -mode=normal grep line<cr>

" moviendonos en el historial del yank
" nnoremap <space>y :Unite history/yank<cr>
nnoremap <leader>y :Denite -mode=normal register<cr>

" COLORSCHEME
" ------------------------------------------------------------------------------------------------------------------------
set termguicolors
colorscheme NeoSolarized

" BUFFER NAVIGATION
" ------------------------------------------------------------------------------------------------------------------------
" next and previous buffer
nnoremap <C-n> :bn<cr>
nnoremap <C-b> :bp<cr>

" WINDOWS NAVIGATION
" ------------------------------------------------------------------------------------------------------------------------
" jump split
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" NETRW
" ------------------------------------------------------------------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_preview = 1
map <F2> :Ex .<CR>

" TAGBAR
" ------------------------------------------------------------------------------------------------------------------------
let g:tagbar_width = 60
nmap <F3> :TagbarToggle<CR>
nmap <leader>t :TagbarOpen j<CR>

" EMMET
"------------------------------------------------------------------------------------------------------------------------
autocmd FileType html,css,js,ts EmmetInstall

" TRANS
"------------------------------------------------------------------------------------------------------------------------
let g:trans_history_file = '~/trans_history.csv'
let g:trans_save_history = 1
let g:trans_advanced_options = "-brief -e bing"
let g:trans_default_direction = ":pt+es"
vnoremap <silent> <leader>T :Trans -brief<CR>
