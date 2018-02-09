#!/bin/bash

VHOME=/opt/local/dconf
HCONF=/opt/local/dconf
HVIM=/opt/local/vim

echo 'downloading vimrc'
curl https://gist.githubusercontent.com/lambdae/adb298f16f55f6ab169bb9e42c36c344/raw/88f076889fe213b54c042da19d87c14e24bd5889/vimrc > vimrc
echo 'installing vundle'
git clone https://github.com/gmarik/vundle.git $VHOME/bundle/vundle

echo "set nocompatible" >> vimrc.new
echo "set rtp+=$HCONF/bundle/vundle/" >> vimrc.new
echo "call vundle#rc(\"$HCONF/bundle/vundle\")" >> vimrc.new
cat vimrc >> vimrc.new
mv vimrc.new vimrc
cp -f vimrc $HCONF


echo "export VIM_DIR=$HVIM" > ~/.limrc
echo "export VIMRUNTIME=\$VIM_DIR/share/vim/vim80" >> ~/.limrc
echo "export EDITOR=dvim" >> ~/.limrc
echo "export PATH=\$VIM_DIR/bin:\$PATH" >> ~/.limrc
echo "alias lim='dvim -u $HCONF/vimrc'" >> ~/.limrc

dvim -u $HCONF/vimrc +BundleInstall +qall

echo 'installing rustup'
curl https://sh.rustup.rs -sSf | sh
RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
echo 'rust src:'$RUST_SRC_PATH

echo 'compiling ycm'
cd $VHOME/bundle/vundle/YouCompleteMe/
./install.py  --racer-completer  --clang-completer --system-libclang



