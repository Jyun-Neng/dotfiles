#!/bin/zsh

# Install Gregory's tmux configuration
# Do not need to use Gregory's `.tmux.conf.local`
# Use my own version of `.tmux.conf.local` in `.tmux`
git clone https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/
