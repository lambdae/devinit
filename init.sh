#!/bin/bash


mkdir -p $HOME/.local

CUSTOM_DIR=$HOME/.local
VHOME=$CUSTOM_DIR/dconf
HCONF=$CUSTOM_DIR/dconf
HVIM=$CUSTOM_DIR/vim
VIMRC=https://gist.githubusercontent.com/lambdae/adb298f16f55f6ab169bb9e42c36c344/raw/ed90e67408f631e246d9a6215157c3a08f12340f/vimrc
GOBIN=go1.10.linux-amd64.tar.gz
GOURL=https://studygolang.com/dl/golang/$GOBIN
GOHOME=$CUSTOM_DIR/go
YCMBIN=YouCompleteMe-git.tgz
YCMURL=http://dconf.oss-cn-beijing.aliyuncs.com/$YCMBIN


mkdir -p $CUSTOM_DIR


function init_vim() {
    echo 'downloading vimrc'
    curl $VIMRC > vimrc
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
    echo "export GOHOME=$GOHOME" >> ~/.limrc
    echo "export EDITOR=dvim" >> ~/.limrc
    echo "export PATH=\$VIM_DIR/bin:\$GOHOME/bin:\$PATH" >> ~/.limrc
    echo "alias lim='dvim -u $HCONF/vimrc'" >> ~/.limrc
}


function install_rust() {
    echo 'installing rustup'
    curl https://sh.rustup.rs -sSf | sh
    RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    echo 'rust src:'$RUST_SRC_PATH
}


function install_go() {
    echo 'installing go'
    cd $CUSTOM_DIR
    wget $GOURL
    tar xvzf $GOBIN
    export GOROOT=$GOHOME
    echo "export GOROOT=\$GOHOME" >> ~/.limrc
}


function build_ycm() {
    echo 'building ycm'
    cd $VHOME/bundle/vundle
    wget $YCMURL
    tar xvzf $YCMBIN
    # mkdir -p _ycm
    # cd _ycm
    # $CMAKE_DIR/bin/cmake -G "Unix Makefiles" -DEXTERNAL_LIBCLANG_PATH=$LIBCLANG . $YCM_DIR/third_party/ycmd/cpp
    # make
    ### ./install.py  --racer-completer  --clang-completer --system-libclang --go-completer
}


init_vim
install_go
# build_ycm

dvim -u $HCONF/vimrc +BundleInstall +qall
# dvim -u $HCONF/vimrc +GoInstallBinaries +qall



