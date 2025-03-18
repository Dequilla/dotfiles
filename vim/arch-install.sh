#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
sudo pacman -S bat the_silver_searcher ripgrep

# TODO: (switch to nightly) Ensure vim is installed
sudo pacman -S neovim

# Copy vimrc to correct location 
cp -r ./nvim/ $CONF_HOME/
