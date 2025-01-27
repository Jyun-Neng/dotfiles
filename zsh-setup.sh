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
# 3. fzf
# Install fzf through git
# Follow this step: https://github.com/junegunn/fzf#using-git
# This is a command-line fuzzy finder
echo $fg_bold[green] "Install fzf"
echo $fg[white] ""
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --update-rc
# 4. zsh vi mode
echo $fg_bold[green] "Install zsh-vi-mode"
echo $fg[white] ""
git clone https://github.com/jeffreytse/zsh-vi-mode \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode
