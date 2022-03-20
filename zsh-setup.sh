#!/bin/zsh

# Enable echo with colors
autoload colors
colors
# Install zsh powerlevel10k theme
# https://github.com/romkatv/powerlevel10k#oh-my-zsh
echo $fg_bold[green] "Install powerlevel10k theme"
echo $fg[white] ""
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Install zsh plugins
# 1. fish-like autosuggestions
echo $fg_bold[green] "Install zsh-autosuggestions plugin"
echo $fg[white] ""
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 2. syntax highlight
echo $fg_bold[green] "Install fast-syntax-hilighting plugin"
echo $fg[white] ""
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
# Install nnn file manager
# Before install nnn, install pkg-config first
brew install pkg-config
# `preview-tui` plugin needs install tree to preview directory tree
brew install tree
echo $fg_bold[green] "Install nnn file manager"
echo $fg[white] ""
git clone https://github.com/jarun/nnn.git ~/.nnn
pushd ~/.nnn
make O_NERD=1 # support icons nerd font
mkdir -p bin
mv nnn bin
popd
# Install autojump
# This is a fast filesystem navigation tool using `j` command.
# After installing autojump, you might need to modify the interpreter declared in
# `~/.autojump/bin/autojump` to python3 if python is not exist in your
# environment.
echo $fg_bold[green] "Install autojump"
echo $fg[white] ""
pushd ~/.nnn
git clone https://github.com/wting/autojump.git ~/autojump
pushd ~/autojump
python3 install.py
popd
echo $fg_bold[red] "You might need to change interpreter declared in"
echo $fg_bold[red] "\`~/.autojump/bin/autojump\` to python3 if python is not exist"
echo $fg[white] ""
# Install fzf through git
# Follow this step: https://github.com/junegunn/fzf#using-git
# This is a command-line fuzzy finder
echo $fg_bold[green] "Install fzf"
echo $fg[white] ""
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc
