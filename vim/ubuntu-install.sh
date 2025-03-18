#!/bin/bash

CONF_HOME=~/.config

# Prerequesits
# fzf 
sudo apt install bat silversearcher-ag ripgrep

# We want nightly to support the features for my plugins
sudo snap install --edge nvim --classic

# Copy configuration files to correct location 
cp -r ./nvim/ $CONF_HOME/
