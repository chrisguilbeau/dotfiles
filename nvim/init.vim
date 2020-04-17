call plug#begin('~/dotfiles/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'will133/vim-dirdiff' " diff two directories!
Plug 'pechorin/any-jump.vim' " find anything without tags
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " backend
Plug 'junegunn/fzf.vim' " all around searcher
Plug 'vimjas/vim-python-pep8-indent' " fix python indentation
Plug 'dense-analysis/ale' " linter
Plug 'ludovicchabant/vim-lawrencium' " hg wrapper
Plug 'junegunn/vim-easy-align' " make things line up rm-style
Plug 'tpope/vim-repeat' " repeat things with ] and [
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar' " allows for which function
call plug#end()

" vim settings
set clipboard=unnamed " set clipboard to system clipboard (gui compile req)
set notimeout " wait forever for leader sequences
set showcmd " show command as you type it
set formatoptions+=l " dont ever wrap lines
set ignorecase " ignore case while searching

" statusline
set laststatus=2                                "always show status line
set statusline=\                                " start it off
set statusline+=%f\                             "File+path
set statusline+=%m\ "
if match(&runtimepath, 'Tagbar') != -1
    set statusline+=[
    " set statusline+=%#TagBarColor#
    set statusline+=%{tagbar#currenttag('%s','','f')}
    " set statusline+=%#StatusLine#
    set statusline+=]
else
    echo "Tagbar Not Installed"
endif
set statusline+=%*%=
set statusline+=%R%W%Y
set statusline+=,%{&ff}                       "FileFormat (dos/unix..)
set statusline +=%5l                          "current line
set statusline +=/%L                         "total lines
set statusline +=\                              "just a space

" ale
au BufNewFile,BufRead *.py call ale#toggle#Enable()
let g:ale_linters = { 'python': ['pyflakes'], 'javascript': ['jshint'] }
lef g:ale_jshint_config_loc = '$VIMHOME/dotfiles/jshint.config'
let g:python_pyflakes_executable = 'c:/ZogoTech/src/server/bin/zpyflakes'
let g:ale_enabled = 0
nmap <leader>ll :lopen<cr>
nmap <leader>lc :lclose<cr>

" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --follow --path-separator /'
let $FZF_DEFAULT_OPTS = '--color=bw'
let $PYTHONUNBUFFERED = 1
nmap <leader>e :FZF<cr>
nmap <leader>b :BTags<cr>
nmap <leader>t :Tags<cr>

" colors
set termguicolors
set bg=light

" set spell for certain things
autocmd FileType hgcommit setlocal spell
autocmd FileType gitcommit setlocal spell

" whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd BufWritePre * :call TrimWhitespace() " autotrim whitespace on save

" column markers
set cc=80
autocmd FileType python set cc=73,80
vmap <leader>wc <esc>:set textwidth=79<cr>gvgq<esc>:set textwidth=0<cr>gv
vmap <leader>wt <esc>:set textwidth=72<cr>gvgq<esc>:set textwidth=0<cr>gv

" show tabs
set list
set listchars=tab:>-

" python indentation
let g:python_pep8_indent_multiline_string = -2
let g:python_pep8_indent_hang_closing = 1

" diffing things
set diffopt+=context:9999
hi DiffAdd ctermfg=15 guifg=NONE ctermbg=10 guibg=darkseagreen1
hi DiffChange ctermfg=15 guifg=black ctermbg=11 guibg=lightcyan1
hi DiffText ctermfg=15 guifg=black ctermbg=1 guibg=cadetblue1
hi DiffDelete ctermfg=15 guifg=mistyrose ctermbg=12 guibg=mistyrose
nmap <leader>dj :bufdo diffoff<cr><C-w>jj<return>
nmap <leader>dk :bufdo diffoff<cr><C-w>jk<return>

" zogotech things
function! Zinit()
    " change the root directory
    cd c:/ZogoTech/src
    " tag project files
    " term ++close ctags -R --exclude=.hg --exclude=*.min.js --exclude=3p --languages=Python,Javascript --python-kinds=cfmvl appserver server webserver
    let $FZF_DEFAULT_COMMAND = 'rg --files --follow --type=py --type=js --type=txt --type=css --path-separator / appserver server webserver'
    edit .
endfunc
" function! ZdiffDone(...)
"     execute 'setlocal cursorline'
"     nmap <buffer> <return> :on<cr>0/Z<cr><C-w>f<C-w>r<C-w><C-w>/c:<cr>v/differ<cr>hhy<C-w><C-w>:setlocal number<cr>:vert diffsplit "<cr>:setlocal number<cr><C-w><C-r>
" endfunc
" function! Zdiff()
"     execute 'tabnew'
"     call term_start("/ZogoTech/src/python/python.exe /ZogoTech/scripts/zc.py", {'exit_cb':function('ZdiffDone')})
" endfunc
function! ZdiffPrompt()
    execute 'tabnew'
    let curline = getline('.')
    call inputsave()
    let left = input('left: ', "c:\\ZogoTech\\hg\\", "file")
    let right = input('left: ' . left . '; ' . 'right: ', "c:\\ZogoTech\\src", "file")
    call inputrestore()
    let g:DirDiffExcludes = ".hg,*.pyc,*.DS_Store,__pycache__"
    execute "DirDiff " . left . " " . right
endfunc
nmap <leader>07 :%s/<c-r>=substitute(substitute(substitute(substitute(substitute(substitute(substitute(@0, 'ALVIN', '.*', 'g'), '\\', '\\\\', 'g'), '\]', '\\]', 'g'), '\[', '\\[', 'g'), '[0-9]\+', '\[0-9\]\\+', 'g'), '\n','\\n','g'), '/', '\\/', 'g')<CR>//gc
function! Zimport()
    term ++close clipimport.bat
endfunc
nmap <leader>zc :call ZdiffPrompt()<cr>
" nmap <leader>zp :call ZdiffPrompt()<cr>
nmap <leader>zz :call Zinit()<cr>
nmap <leader>zi :call Zimport()<cr>
nmap <leader>zg :grep -tpy -tjs -w<Space>
nmap <leader>si (V):EasyAlign /\<import\>/<cr>gvk:sort i<cr>

" abbreviations
ab pdb breakpoint() # TODO: remove this!!!

" open config file
nmap <leader>i :edit ~/dotfiles/nvim/init.vim<cr>
" reload current file (for config mostly)
nmap <leader>ii :so %<cr>
nmap <leader>zd :TermdbgPdb /ZogoTech/src/webserver/bin/wsd.py -Sidls -m1
" paste what you meant to paste
nmap <leader>p "0p
" toggle highlight
nmap <leader>h :set hlsearch! hlsearch?<CR>
" toggle numbers
nmap <leader>n :set number!<cr>
" replace search!
nmap <leader>r yiw:,$s/"//gc<left><left><left>
vmap <leader>r y:,$s/"//gc<left><left><left>

" disable things that accidentally get hit...
imap <NUL> <Space>
nmap <F1> <nop>
imap <F1> <nop>
vmap <S-Up> <nop>
vmap <S-Down> <nop>
nmap <S-Up> <nop>
imap <S-Up> <nop>
imap <S-Down> <nop>
nmap <S-Down> <nop>
