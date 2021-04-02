" GENERAL INITAL CONFIG
"------------------------------------------------------------------------------------------------------------------------
highlight ColorColumn ctermbg=233 guibg=#444444
set colorcolumn=80
set modeline " tiene algo que ver con el identado pero no se realmente de que va
set tw=79   " width of document (used by gd)
set fo-=t   " don't automatically wrap text when typing
set number relativenumber " mustra la columna con el numero de linea
set cursorline
set noswapfile " no genera archivos *.swp
set nowrap
set clipboard+=unnamedplus
set nohlsearch
set encoding=UTF-8
set guifont=DroidSansMono\ Nerd\ Font\ 11
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

" GENERAL PLUGINS
"------------------------------------------------------------------------------------------------------------------------
    Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}
    Plug 'fmoralesc/vim-tutor-mode'
    Plug 'neomake/neomake'
    Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'iCyMind/NeoSolarized'
    Plug 'mattn/emmet-vim'
    Plug 'kshenoy/vim-signature'
    Plug 'jreybert/vimagit'
    Plug 'wakatime/vim-wakatime'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'sbdchd/neoformat'
    Plug 'neovim/nvim-lspconfig'

    " PYTHON
    "---------------------------------------------------------------------------
    Plug 'davidhalter/jedi-vim'
    Plug 'zchee/deoplete-jedi'

call plug#end()

" SNIPPETS
"------------------------------------------------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:ultisnips_php_scalar_types = 1


" floating fzf window with borders
function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

" Files + devicons + floating fzf
function! Fzf_dev()
  let l:fzf_files_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'
  function! s:files()
    let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []
    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})

endfunction

" FZF TODO: WAIT to 0.5.0 neovim version its available

" general
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
let $FZF_DEFAULT_OPTS="--reverse " " top to bottom

" use rg by default
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

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

" EMMET
"------------------------------------------------------------------------------------------------------------------------
autocmd FileType html,css,js,ts EmmetInstall

" DEOPLETE
"------------------------------------------------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
"
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

" NEOFORMAT
"------------------------------------------------------------------------------------------------------------------------
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" NEOMAKE
"------------------------------------------------------------------------------------------------------------------------
let g:neomake_highlight_columns = 0
let g:neomake_highlight_lines = 1
let g:neomake_place_signs = 1
let g:neomake_python_enabled_makers = ['python', 'flake8', 'mypy', 'pylint']
let g:neomake_shellcheck_args = ['-fgcc']

" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" FZF Funky
"------------------------------------------------------------------------------------------------------------------------
nnoremap <Leader>fu :FzfFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'FzfFunky ' . expand('<cword>')<Cr>
"
" FZF
" ------------------------------------------------------------------------------------------------------------------------
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" buscar un archivo
nnoremap <C-p> :Files .<cr>
" nnoremap <silent> <leader>f :call Fzf_dev()<CR> TODO: WAIT for release 0.5 of Neovim
" buscar un buffer
nnoremap <leader>b :Buffers<cr>
" buscar en el contenido de un archivo (ag)
nnoremap <leader>/ :Ag<cr>
