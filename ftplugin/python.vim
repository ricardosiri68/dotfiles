setlocal shiftwidth=4
setlocal tabstop=4
setlocal expandtab

map <buffer> <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
map <buffer> <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

