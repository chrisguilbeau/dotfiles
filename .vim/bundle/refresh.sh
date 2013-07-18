#!/bin/bash
declare -a repos=(
    https://github.com/kien/ctrlp.vim.git
    https://github.com/altercation/vim-colors-solarized.git
    https://github.com/scrooloose/nerdcommenter.git
    https://github.com/nathanaelkane/vim-indent-guides.git
    https://github.com/terryma/vim-multiple-cursors.git
    https://github.com/Lokaltog/vim-powerline.git
    )

# delete all directories
rm -rf */

# reclone everything
for repo in ${repos[@]}
    do
        echo "cloning $repo..."
        git clone $repo
        done
