#!/bin/bash

VHOME=~/.vim
echo 'downloading vimrc'
curl https://gist.githubusercontent.com/lambdae/adb298f16f55f6ab169bb9e42c36c344/raw/88f076889fe213b54c042da19d87c14e24bd5889/vimrc > vimrc
echo 'installing vundle'
git clone https://github.com/gmarik/vundle.git $VHOME/bundle/vundle
cp -f vimrc ~/.vimrc
cp -f vimrc $VHOME
vim +BundleInstall +qall

echo 'installing rustup'
curl https://sh.rustup.rs -sSf | sh
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
echo 'rust src:'$RUST_SRC_PATH

echo 'compiling ycm'
cd $VHOME/bundle/YouCompleteMe/
./install.py  --racer-completer  --clang-completer --system-libclang



