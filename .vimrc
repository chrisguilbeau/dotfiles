syntax on "syntax highlighting
set tags=tags;/ "search for a tags file up the tree
set cc=72,79 "put a line for comments and end of code
au Filetype python setl et ts=4 sw=4 "define python tab rules
autocmd BufWritePre *.py :%s/\s\+$//e "remove whitespace on save
set nobackup "turn off backup
set noswapfile
match Todo /\s\+$/ "highlight trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save

" powerline
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
