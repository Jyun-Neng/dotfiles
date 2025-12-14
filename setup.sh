#!/usr/bin/env bash
#
# File: setup.sh
# Description: Uses GNU Stow to symlink configuration files into their target
# locations. This script assumes the current working directory is the root
# of the dotfiles repository.

# Set strict mode: Exit immediately if a command exits with a non-zero status.
# Fail on usage of an uninitialized variable.
set -eu

# --- Configuration ---

# Target directory for general configurations.
readonly CONFIG_DIR="${HOME}/.config"

# Target directory for zsh configuration (usually HOME).
readonly ZSH_TARGET_DIR="${HOME}"

# Target directory for tmux configuration
readonly TMUX_TARGET_DIR="${CONFIG_DIR}/tmux"

# --- Helper Functions ---

# Executes a stow command to symlink a package.
# Arguments:
#   1: The package name (e.g., 'zsh', 'starship').
#   2: The target directory (e.g., '$HOME', '$HOME/.config').
# Returns:
#   0 on success, 1 on failure.
function run_stow() {
  local package="$1"
  local target_dir="$2"

  echo "Attempting to stow '${package}' to '${target_dir}'..."

  # Execute stow command.
  if command stow --target "${target_dir}" "${package}"; then
    echo "SUCCESS: '${package}' stowed successfully."
    return 0
  else
    echo "ERROR: Failed to stow '${package}'." >&2
    return 1
  fi
}

# Checks if a directory exists and creates it if it does not.
# Arguments:
#   1: The directory path to check/create.
function ensure_directory_exists() {
  local dir_path="$1"

  if [[ ! -d "${dir_path}" ]]; then
    echo "Directory '${dir_path}' does not exist. Creating it..."

    # mkdir -p creates parent directories as needed and does not fail if the directory exists.
    if mkdir -p "${dir_path}"; then
      echo "SUCCESS: Directory '${dir_path}' created."
    else
      echo "FATAL: Failed to create directory '${dir_path}'." >&2
      # Exit the entire script on directory creation failure.
      exit 1
    fi
  fi
}

# --- Main Script Execution ---

# Ensure stow is installed before proceeding.
if ! command -v stow &>/dev/null; then
  echo "FATAL: 'stow' command not found. Please install GNU Stow." >&2
  exit 1
fi

# Ensure all the target directories exists before stowing.
ensure_directory_exists "${CONFIG_DIR}"
ensure_directory_exists "${ZSH_TARGET_DIR}"
ensure_directory_exists "${TMUX_TARGET_DIR}"

# Remove existing .zshrc to allow clean symlinking.
rm -rf "$HOME/.zshrc"

# 1. Stow 'zsh' package
run_stow "zsh" "${ZSH_TARGET_DIR}" || exit $?

# 2. Stow 'starship' package
run_stow "starship" "${CONFIG_DIR}" || exit $?

# 3. Stow 'tmux' package
run_stow "tmux" "${TMUX_TARGET_DIR}" || exit $?

echo "---"
echo "Dotfile setup complete."
exit 0
