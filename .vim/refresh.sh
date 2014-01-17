#!/bin/bash
declare -a repos=(
    https://github.com/altercation/vim-colors-solarized.git
    https://github.com/bling/vim-airline
    https://github.com/flazz/vim-colorschemes
    https://github.com/kien/ctrlp.vim.git
    https://github.com/ludovicchabant/vim-lawrencium.git
    https://github.com/mileszs/ack.vim.git
    https://github.com/mkitt/tabline.vim.git
    https://github.com/msanders/snipmate.vim.git
    https://github.com/nathanaelkane/vim-indent-guides.git
    https://github.com/scrooloose/syntastic.git
    https://github.com/terryma/vim-multiple-cursors.git
    https://github.com/tpope/vim-commentary.git
    https://github.com/tpope/vim-fugitive.git
    https://github.com/tpope/vim-surround.git
    https://github.com/vim-scripts/DirDiff.vim.git
    )

# delete all directories
rm -rf ./bundle/*

# reclone everything
pushd ./bundle
for repo in ${repos[@]}
    do
        echo "cloning $repo..."
        git clone $repo
        done
popd
