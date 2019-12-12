call plug#begin('~/dotfiles/nvim/plugged')
Plug 'epheien/termdbg'
call plug#end()

" python setup
let g:termdbg_pdb_prog = 'c:/ZogoTech/scripts/pdb.bat'

" vim settings
set clipboard=unnamed " set clipboard to system clipboard (gui compile req)

" open config file
nmap <leader>i :edit ~/dotfiles/nvim/init.vim<cr>
" reload current file (for config mostly)
nmap <leader>ii :so %<cr>
nmap <leader>zd :TermdbgPdb /ZogoTech/src/webserver/bin/wsd.py -Sidls -m1
