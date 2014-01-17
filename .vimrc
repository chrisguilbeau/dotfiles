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
"set cindent "smart indent for c programs
"filetype plugin indent on "indent files automagically
set tags=tags;/ "search for a tags file up the tree
set cc=72,79 "put a line for comments and end of code
"au Filetype python setl et ts=4 sw=4 "define python tab rules
set expandtab shiftwidth=4 softtabstop=4
set tabstop=4
autocmd BufWritePre *.py :%s/\s\+$//e "remove whitespace on save
set nobackup "turn off backup
set noswapfile
match Todo /\s\+$/ "highlight trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e "delete trailing whitespace on save
set number "always show line numbers
set whichwrap+=<,>,h,l,[,]
set autoread " automatically read files when changed by another editor
set hidden " just hide the buffer till I come back to it
set ignorecase " ignore case while searching
set spell " check spelling in strings
set infercase " use the case that makes sense

" Color theme setup
set t_Co=256 " set colors to 256 for better color scheme support

" airline setup
set laststatus=2 " always show statusbar
set noshowmode " dont show the double insert
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#buffer_nr_show = 1

"NERD Commenter Setup
filetype plugin on "needs this for some reason

" CtrlP setup
set noautochdir "don't change directory when opening new files
let g:ctrlp_follow_symlinks = 1 "follow symlinks into the darkness
let g:ctrlp_extensions = ['tag'] "enable searching of tags (slow)
set wildignore+=*/.git/*,*/.hg/*,*.pyc "don't pick up certain things
let g:ctrlp_working_path_mode = 0
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:30,results:30'

" solarized setup
"let g:solarized_termcolors=256
"colorscheme solarized

" indent guides setup
"let g:indent_guides_enable_on_vim_startup = 1

" syntastic setup
 let g:syntastic_check_on_open = 0
 let g:syntastic_python_checkers = ["pep8"]
 let g:syntastic_python_pep8_args = "--ignore=E272,E221,E302,E123"

 " dirdiff setup
 let g:DirDiffExcludes = ".hg,tags,*.pyc,.*.swp"

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
" V    if(&number == 1)
"         set relativenumber
"         set number
"     elseif(&relativenumber == 1)
"         set norelativenumber
"         set nonumber
"     else
"         set number
"         set norelativenumber
"     endif
endfunc

" highlight sql inside of python
function! TextEnableCodeSnip(filetype,start,end,textSnipHl) abort
  let ft=toupper(a:filetype)
  let group='textGroup'.ft
  if exists('b:current_syntax')
    let s:current_syntax=b:current_syntax
    " Remove current syntax definition, as some syntax files (e.g. cpp.vim)
    " do nothing if b:current_syntax is defined.
    unlet b:current_syntax
  endif
  execute 'syntax include @'.group.' syntax/'.a:filetype.'.vim'
  try
    execute 'syntax include @'.group.' after/syntax/'.a:filetype.'.vim'
  catch
  endtry
  if exists('s:current_syntax')
    let b:current_syntax=s:current_syntax
  else
    unlet b:current_syntax
  endif
  execute 'syntax region textSnip'.ft.'
  \ matchgroup='.a:textSnipHl.'
  \ start="'.a:start.'" end="'.a:end.'"
  \ contains=@'.group
endfunction

nnoremap <C-n> :call NumberToggle()<cr>
 " custom keymaps for great things
 nmap <TAB><TAB>b :CtrlPBufTag<CR>
 nmap <TAB><TAB>d :VCSVimDiff<CR>
 nmap <TAB><TAB>t :tab sball<CR>
 nmap <TAB><TAB>n :call NumberToggle()<CR>
 nmap <TAB><TAB>p :w !python<CR>
 imap <NUL> <Space>
