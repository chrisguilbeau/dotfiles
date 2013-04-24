syntax on
set tags=./tags,tags; " look for tags in current dir then move up till you
set whichwrap+=<,>,h,l,[,] " wrap edged when navigating with arrows
"set cc=79 " draw a ruler at col 79
set title " auto update with the title of the file
match Todo /\t\+/ "highlight tabs
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save
set expandtab " no more tabs!
set tabstop=4
set shiftwidth=4
set incsearch
set hlsearch
set ruler
set autoindent
set smartindent
set nobackup
set cindent
set nowrap
