#!/bin/bash
declare -a repos=(
    # https://github.com/vim-scripts/taglist.vim.git
    # git://github.com/majutsushi/tagbar
    # git://github.com/flazz/vim-colorschemes
    # git://github.com/hsitz/VimOrganizer.git
    # git://github.com/scrooloose/syntastic.git
    git://github.com/altercation/vim-colors-solarized.git
    git://github.com/bling/vim-airline
    git://github.com/kien/ctrlp.vim.git
    git://github.com/ludovicchabant/vim-lawrencium.git
    git://github.com/mileszs/ack.vim.git
    git://github.com/mkitt/tabline.vim.git
    git://github.com/msanders/snipmate.vim.git
    git://github.com/terryma/vim-multiple-cursors.git
    git://github.com/tpope/vim-commentary.git
    git://github.com/tpope/vim-fugitive.git
    git://github.com/tpope/vim-surround.git
    git://github.com/tpope/vim-unimpaired.git
    git://github.com/vim-scripts/DirDiff.vim.git
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
