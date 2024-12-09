#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
# fzf 
sudo apt install bat silversearcher-ag ripgrep

# Ensure vim is installed
sudo apt install -y neovim

# Setup folders
mkdir -p $CONF_HOME/nvim/autoload $CONF_HOME/nvim/plugged $CONF_HOME/nvim/colors

# Install plugin for handling plugins
curl -fLo $CONF_HOME/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc to correct location 
cp -r ./nvim/init.vim $CONF_HOME/nvim/init.vim

# Install plugins
nvim +'PlugInstall' +'qa'
