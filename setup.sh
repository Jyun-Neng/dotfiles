#!/usr/bin/env bash
#
# File: setup.sh
# Description: Uses GNU Stow to symlink configuration files into their target
# locations. This script assumes the current working directory is the root
# of the dotfiles repository.

# --- Configuration ---

# Target directory for general configurations.
readonly CONFIG_DIR="${HOME}/.config"

# Target directory for zsh configuration (usually HOME).
readonly ZSH_TARGET_DIR="${HOME}"

# --- Helper Functions ---

# Function to execute a stow command and check its success.
# Arguments:
#   1: The package name (e.g., 'zsh', 'starship').
#   2: The target directory (e.g., '$HOME', '$HOME/.config').
function run_stow() {
  local package="$1"
  local target_dir="$2"

  echo "Attempting to stow '${package}' to '${target_dir}'..."

  # The main stow command execution.
  if command stow --target "${target_dir}" "${package}"; then
    echo "SUCCESS: '${package}' stowed successfully."
  else
    # Output error details if the command fails.
    echo "ERROR: Failed to stow '${package}'." >&2
    # Exit with a non-zero status to indicate failure.
    return 1
  fi
}

# --- Main Script Execution ---

# Ensure stow is installed before proceeding.
if ! command -v stow &>/dev/null; then
  echo "FATAL: 'stow' command not found. Please install GNU Stow." >&2
  exit 1
fi

rm -rf "$HOME/.zshrc"

# 1. Stow 'zsh' package to the home directory.
# This assumes the 'zsh' directory in your dotfiles contains files/dirs
# that should go directly into $HOME (e.g., .zshrc).
run_stow "zsh" "${ZSH_TARGET_DIR}" || exit $?

# 2. Stow 'starship' package to the .config directory.
# This is explicitly what you requested for starship.
run_stow "starship" "${CONFIG_DIR}" || exit $?

echo "---"
echo "Dotfile setup complete."
exit 0
