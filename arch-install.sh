#!/bin/bash

# Prerequesits
sudo pacman -S --noconfirm bat silversearcher-ag ripgrep

# Ensure vim is installed
sudo pacman -S --noconfirm vim

# Setup folders
mkdir -p $HOME/.vim/autoload $HOME/.vim/plugged $HOME/.vim/colors

# Colorscheme
curl -o $HOME/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# Install plugin for handling plugins
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc to correct location 
cp ./vimrc $HOME/.vimrc
