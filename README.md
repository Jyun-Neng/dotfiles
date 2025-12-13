# Jyun-Neng's macOS Dotfiles

## 🌟 Introduction

This repository contains my personal dotfiles for setting up and configuring a new macOS environment.

Feel free to copy, adapt, and use any parts for your own setup!

## 🛠️ Prerequisites & Initial Setup

Before applying these configurations, please ensure you have the following tools and steps completed:

### Essential Tools

* [**Homebrew**](https://brew.sh/): A package manager for macOS.
* [**GNU Stow**](https://www.gnu.org/software/stow/): Used for managing and symlinking the dotfiles into their respective directories.
    ```shell
    brew install stow
    ```
* [**Starship**](https://starship.rs/): A minimal, blazing-fast, and infinitely customizable prompt for any shell.
    ```shell
    brew install starship 
    ```
* [**Nerd Fonts Repository**](https://github.com/ryanoasis/nerd-fonts): Provides beautiful, enhanced fonts for terminal use.

### Recommended Setup Guide

I highly recommend following this [**video**](https://youtu.be/RNqDkF17ogY) guide for the general setup of your Mac (you can skip the part where he installs his personal dotfiles):

## 🚀 Configuration Guides

Once the prerequisites are met, follow the steps below to configure the individual components.

---

### 1. Shell (ZSH) Setup

This configuration uses Zsh along with several popular plugins.

1.  **Install Oh My Zsh and Zsh Plugins**
    * This script installs [Oh My Zsh](https://ohmyz.sh), [fzf](https://github.com/junegunn/fzf), and all required Zsh plugins.
    ```shell
    bash zsh-setup.sh
    ```
    > **Note:** To learn how to use `fzf`, please refer to the linked repository.

2.  **Create Configuration Symlinks**
    * Use the main setup script to create symlinks for all ZSH configuration files in their corresponding directories using `stow`.
    ```shell
    bash setup.sh
    ```

3.  **Apply Fast-Syntax-Highlighting Theme**
    * **Restart** your terminal session.
    * Switch the fast-syntax-highlighting theme to `Catppuccin-Mocha`.
    ```shell
    fast-theme XDG:catppuccin/themes/catppuccin-mocha
    ```

---

### 2. TMUX Setup (WIP - Work In Progress)

* *Currently under development.*

---

### 3. Neovim Setup (WIP - Work In Progress)

1.  **Review Neovim README**
    * Please read the specific setup instructions for the Neovim configuration.
    * [**Neovim Configuration README**](https://github.com/Jyun-Neng/dotfiles/tree/master/.neovim/README.md)

