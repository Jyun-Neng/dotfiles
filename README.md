# Jyun-Neng's dotfiles for macOS

![cover](./images/cover.png)

## Introduction

This repository serves as my way to setup my Mac. Feel free to copy parts for your own dotfiles.

## Setting up your Mac

### Before you apply this repo to set up your Mac

I recommand you follow this [video](https://youtu.be/RNqDkF17ogY) to set up your Mac first. But you do not have to install his dotfiles.

Another tool you need is [GNU Stow](https://www.gnu.org/software/stow/). I use this to manage my dotfiles.

```shell
brew install stow
```

After you did all above, you may now follow instructions below to setup

1. shell (ZSH), 
2. tmux, and
3. neovim (TODO)

### Setting up ZSH

1. Install [Oh My Zsh](https://ohmyz.sh)
```shell
./install-oh-my-zsh.sh
```
2. Install all plugins and tools required in zsh configurations
```shell
./install-nnn-plugins.sh
./zsh-setup.sh
```
3. Create symlink of all zsh configurations to your `$HOME` directory
```shell
stow .zsh
```

**NOTE**: `zsh-setup.sh` will install [nnn](https://github.com/jarun/nnn), [fzf](https://github.com/junegunn/fzf), and [autojump](https://github.com/wting/autojump). To know how to use these tools, you can enter each link.

### Setting up Tmux
For Tmux configuration, I recommand using [Gregory's Tmux configurations](https://github.com/gpakosz/.tmux).

1. Install Gregory's Tmux configuration
```shell
./tmux-setup.sh
```
2. Create symlink of my tmux configuration to your `$HOME` directory
```shell
stow .tmux
```
