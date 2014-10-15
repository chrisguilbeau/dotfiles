"""" setup pathogen for installing plugins with ease
execute pathogen#infect()
Helptags

syntax on "syntax highlighting
set clipboard=unnamed " set clipboard to system clipboard (gui compile req)
set backspace=2 " make backspace behave correctly!
" set hlsearch "highlight all matches while searching
set incsearch "jump to first match when searching
"set autoindent "indent to the previous level
set smartindent " indent one level next
"set cindent "smart indent for c languages
filetype plugin on "make commands smarter for your file ]m and the like
set tags=tags;/ "search for a tags file recursively till it finds one
set cc=72,79 "put a line for comments and end of code pep8
set expandtab shiftwidth=4 softtabstop=4
set tabstop=4
" set backupdir-=. "remove cwd from backups list
" set backupdir^=~/.vim/backups "set backups to this folder
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save
" set number " show line numbers
" set relativenumber " show the relative numbers
set autoread " automatically read files when changed by another editor
set hidden " just hide the buffer till I come back to it
set ignorecase " ignore case while searching
" set spell " check spelling in strings
set complete-=i " don't scan all included files for autocomplete!
set wildignore+=*/.git/*,*/.hg/*,*.pyc,*.DS_Store "don't pick up certain things
set nofoldenable " no code folding ever!!!
set path=*/**
set noswapfile
set nobackup

" Color theme setup
set t_Co=256 " set colors to 256 for better color scheme support

" colors solarized

" syntastic
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': [] }
let g:syntastic_python_checkers = ['pyflakes']

" commentary - set commenter for certain filetypes
autocmd FileType vim set commentstring=\"\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType javascript set commentstring=//\ %s

" airline setup
set laststatus=2 " always show statusbar
set noshowmode " dont show the double insert
" let g:airline#extensions#tabline#enabled = 1 "turn on tabs
" let g:airline#extensions#tabline#tab_min_count = 2 "only show when 2 or more
" let g:airline#extensions#tabline#buffer_min_count = 2
" let g:airline#extensions#tabline#buffer_nr_show = 1

" CtrlP setup
let g:ctrlp_follow_symlinks = 1 "follow symlinks into the darkness
let g:ctrlp_extensions = ['tag'] "enable searching of tags
let g:ctrlp_working_path_mode = 0

" 2html
" let g:html_font = 'Menlo'
" " let g:html_number_lines = 0
" let g:html_use_css = 0

" dirdiff setup
let g:DirDiffExcludes = ".hg,tags,*.pyc,.*.swp,.DS_Store"
set diffopt+=context:99999

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


function! InsertPdbLine()
    let trace = expand("import pdb; pdb.set_trace()")
    execute "normal o".trace
endfunction

" dirdiff setup
let g:DirDiffExcludes = ".hg,tags,*.pyc,.*.swp"

" custom keymaps for great things
nmap <tab><tab>p :call InsertPdbLine()<CR>
nmap <tab><tab>r :vertical resize 90<CR>
nmap <tab><tab>b :CtrlPBufTag<CR>
nmap <tab><tab>s :setlocal spell! spell?<CR>
nmap <tab><tab>n :call NumberToggle()<CR>
" nmap <tab><tab>h :wincmd k <BAR> :TOhtml <BAR> w! ~/Desktop/out.html <BAR> bdelete! <BAR> :wincmd j<CR>
imap <NUL> <Space>
