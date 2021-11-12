# Setup folders
mkdir -p ~/.vim/autoload ~/.vim/plugged ~/.vim/colors

# Colorscheme
curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

# Install plugin for handling plugins
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy vimrc to correct location 
cp ./vimrc ~/.vimrc
