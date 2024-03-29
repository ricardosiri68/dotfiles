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
    "--------------------------------------------------------------------------
    Plug 'neomake/neomake'
    Plug 'fmoralesc/vim-tutor-mode'
    Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
    Plug 'iCyMind/NeoSolarized'
    Plug 'kshenoy/vim-signature'
    Plug 'wakatime/vim-wakatime'
    Plug 'jeffkreeftmeijer/vim-numbertoggle'

    " NOT LSP
    "--------------------------------------------------------------------------
    Plug 'sheerun/vim-polyglot'
    Plug 'sbdchd/neoformat'

    " LSP
    "--------------------------------------------------------------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'

    " HTML|CSS
    "--------------------------------------------------------------------------
    Plug 'mattn/emmet-vim'

    " GIT
    "--------------------------------------------------------------------------
    Plug 'jreybert/vimagit'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    " TELESCOPE
    "--------------------------------------------------------------------------
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    
    " TREESITTER
    "--------------------------------------------------------------------------
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

call plug#end()

" SNIPPETS
"------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:ultisnips_php_scalar_types = 1

" COLORSCHEME
" -----------------------------------------------------------------------------
set termguicolors
colorscheme NeoSolarized

" BUFFER NAVIGATION
" -----------------------------------------------------------------------------
" next and previous buffer
nnoremap <C-n> :bn<cr>
nnoremap <C-b> :bp<cr>

" WINDOWS NAVIGATION
" -----------------------------------------------------------------------------
" jump split
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" NETRW
" -----------------------------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_preview = 1
map <F2> :Ex .<CR>

" EMMET
"------------------------------------------------------------------------------
autocmd FileType html,css,js,ts EmmetInstall

" NEOFORMAT
"------------------------------------------------------------------------------
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" NEOMAKE
"------------------------------------------------------------------------------
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

" LSP - PYTHON
"------------------------------------------------------------------------------
" deoplete keymap
inoremap <C-x><C-o> <C-n>

lua << EOF
local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end
EOF

" ASYNCOMPLETE
" -----------------------------------------------------------------------------
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

" TELESCOPE
" -----------------------------------------------------------------------------
" List all files for a search
nnoremap <leader>ff <cmd>Telescope find_files<cr>
" List the result of a grep search
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" Searches for a string under the cursor in current directory.
nnoremap <leader>fG <cmd>Telescope grep_string<cr>
"  	Lists Open buffers in the current vim instance.
nnoremap <leader>fb <cmd>Telescope buffers show_all_buffers=true<cr>
"  	Lists Previously open files.
nnoremap <leader>fO <cmd>Telescope oldfiles<cr>
"  	Lists Open buffers in the current vim instance.
nnoremap <leader>fB <cmd>Telescope file_browser<cr>
"  	Lists treesitter maps of the current buffer
nnoremap <leader>tt <cmd>Telescope treesitter<cr>
"  	Lists Available plugin/user commands and run it.
nnoremap <leader>fc <cmd>Telescope commands<cr>
"  	Lists Commands previously ran and run it on enter.
nnoremap <leader>ch <cmd>Telescope command_history<cr>
"  	Lists Searches previously ran and run it on enter.
nnoremap <leader>sh <cmd>Telescope search_history<cr>
"  	Lists Available help tags and open help document.
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"  	Lists Man entries.
nnoremap <leader>mp <cmd>Telescope man_pages<cr>
"  	Lists Markers and their value.
nnoremap <leader>mk <cmd>Telescope marks<cr>
"  	Lists Colorscheme and switch to it on enter.
nnoremap <leader>cs <cmd>Telescope colorscheme<cr>
"  	Lists items from quickfix.
nnoremap <leader>fq <cmd>Telescope quickfix<cr>
"  	Lists items from current window's location list.
nnoremap <leader>ll <cmd>Telescope loclist<cr>
"  	Lists vim options and on enter edit the options value.
nnoremap <leader>vo <cmd>Telescope vim_options<cr>
"  	Lists vim registers and edit or paste selection.
nnoremap <leader>re <cmd>Telescope registers<cr>
"  	Lists vim autocommands and go to their declaration.
" " FIX: nnoremap <leader>ac <cmd>Telescope autocommands<cr>
"  	Lists spelling suggestions for .
" " FIX: nnoremap <leader>ss <cmd>Telescope spell_suggest<cr>
"  	Lists normal-mode mappings.
nnoremap <leader>km <cmd>Telescope keymaps<cr>
"  	Lists all filetypes.
nnoremap <leader>fT <cmd>Telescope filetypes<cr>
"  	Lists all highlights.
nnoremap <leader>hl <cmd>Telescope highlights<cr>
"  	Searches in current buffer lines.
nnoremap <leader>bf <cmd>Telescope current_buffer_fuzzy_find<cr>
"  	GIT
" -----------------------------------------------------------------------------
"  	Lists git files in the current working tree
nnoremap <leader>gf <cmd>Telescope git_files<cr>
"  	Lists git commits with diff preview and on enter checkout the commit.
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
"  	Lists buffer's git commits with diff preview and checkouts it out on enter.
nnoremap <leader>gC <cmd>Telescope git_bcommits<cr>
"  	Lists all branches with log preview, checkout action (), track action ()
"  	and rebase action().
nnoremap <leader>gb <cmd>Telescope git_branches<cr>
"  	Lists current changes per file with diff preview and add action.
"  	(Multi-selection still WIP)
nnoremap <leader>gs <cmd>Telescope git_status<cr>
" LSP - TELESCOPE
" -----------------------------------------------------------------------------
" List of definitions of the word under the cursor
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
" List to references of the word under the cursor
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>ds <cmd>Telescope lsp_document_symbols<cr>
