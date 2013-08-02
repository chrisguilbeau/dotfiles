" setup pathogen for installing plugins with ease
execute pathogen#infect()
Helptags

syntax on "syntax highlighting
"set cursorline "highlight the current line
"set hlsearch "highlight all matches while searching
set incsearch "jump to first match when searching
"set autoindent "indent to the previous level
set smartindent " indent one level next
"set cindent "smart indent for c programs
"filetype plugin indent on "indent files automagically
set tags=tags;/ "search for a tags file up the tree
set cc=72,79 "put a line for comments and end of code
"au Filetype python setl et ts=4 sw=4 "define python tab rules
set expandtab shiftwidth=4 softtabstop=4
autocmd BufWritePre *.py :%s/\s\+$//e "remove whitespace on save
set nobackup "turn off backup
set noswapfile
match Todo /\s\+$/ "highlight trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save
set t_Co=256 " set colors to 256 for better color scheme support
set number "always show line numbers

" Powerline Setup
"let g:Powerline_symbols = "fancy"
set laststatus=2 " always show statusbar
"set encoding=utf-8 " Necessary to show Unicode glyphs
"set guifont=Source\ Code\ Pro\ for\ Powerline
"set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set noshowmode " dont show the double insert

"NERD Commenter Setup
filetype plugin on "needs this for some reason

" CtrlP setup
set noautochdir "don't change directory when opening new files
let g:ctrlp_follow_symlinks = 1 "follow symlinks into the darkness
let g:ctrlp_extensions = ['tag'] "enable searching of tags (slow)
set wildignore+=*/.git/*,*/.hg/*,*.pyc "don't pick up certain things

" solarized setup
"colorscheme solarized

" indent guides setup
"let g:indent_guides_enable_on_vim_startup = 1
