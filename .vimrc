"""" setup pathogen for installing plugins with ease
execute pathogen#infect()
Helptags

syntax on "syntax highlighting
set clipboard=unnamed " set clipboard to system clipboard (gui compile req)
set backspace=2 " make backspace behave correctly!
"set nowrap "put everything on one line!
"set cursorline "highlight the current line
"set hlsearch "highlight all matches while searching
set incsearch "jump to first match when searching
"set autoindent "indent to the previous level
set smartindent " indent one level next
"set cindent "smart indent for c languages
filetype plugin on "make commands smarter for your file ]m and the like
set tags=tags;/ "search for a tags file recursively till it finds one
set cc=72,79 "put a line for comments and end of code pep8
set expandtab shiftwidth=4 softtabstop=4
set tabstop=4
set nobackup "turn off backup
set noswapfile
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save
set number " show line numbers
set relativenumber " show the relative numbers
set autoread " automatically read files when changed by another editor
set hidden " just hide the buffer till I come back to it
set ignorecase " ignore case while searching
" set spell " check spelling in strings
set complete-=i " don't scan all included files for autocomplete!

" Color theme setup
set t_Co=256 " set colors to 256 for better color scheme support

" commentary - set commenter for certain filetypes
autocmd FileType vim set commentstring=\"\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType javascript set commentstring=//\ %s

" airline setup
set laststatus=2 " always show statusbar
set noshowmode " dont show the double insert
let g:airline#extensions#tabline#enabled = 1 "turn on tabs
let g:airline#extensions#tabline#tab_min_count = 2 "only show when 2 or more
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 1

" CtrlP setup
let g:ctrlp_follow_symlinks = 1 "follow symlinks into the darkness
let g:ctrlp_extensions = ['tag'] "enable searching of tags
set wildignore+=*/.git/*,*/.hg/*,*.pyc "don't pick up certain things
let g:ctrlp_working_path_mode = 0

 " dirdiff setup
 let g:DirDiffExcludes = ".hg,tags,*.pyc,.*.swp"

" 2html
let g:html_font = 'Menlo'
" let g:html_number_lines = 0
let g:html_use_css = 0

" custom functions...
function! NumberToggle()
    if (&relativenumber == 1)
        set norelativenumber
        set nonumber
    elseif(&number == 0)
        set number
    else
        set relativenumber
    endif
endfunc

" gui related things
if has("gui_running")
    set guifont=Monaco:h14
    colors solarized
endif

nnoremap <C-n> :call NumberToggle()<cr>
 " custom keymaps for great things
 nmap <tab><tab>t :CtrlPBufTag<CR>
 nmap <tab><tab>s :setlocal spell! spell?<CR>
 nmap <tab><tab>n :call NumberToggle()<CR>
 nmap <tab><tab>p :w !python<CR>
 nmap <tab><tab>h :wincmd k <BAR> :TOhtml <BAR> w! ~/Desktop/out.html <BAR> bdelete! <BAR> :wincmd j<CR>
 imap <NUL> <Space>
