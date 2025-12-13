#!/usr/bin/env bash
#
# File: zsh-setup.sh
# Description: Installs Oh My Zsh and clones essential Zsh plugins (autosuggestions,
# syntax highlighting, fzf, and vi mode) into the standard custom plugin directory.

# Set strict execution mode: Exit on error, exit on unset variables.
set -eu

# --- Configuration and Constants ---

# ANSI Color Codes (Variables named consistently with common usage)
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_BOLD_GREEN='\033[1;32m'
readonly COLOR_WHITE='\033[0;37m'
readonly COLOR_RED='\033[0;31m'
readonly COLOR_NC='\033[0m' # No Color

# Determine the custom plugins directory.
# Uses ZSH_CUSTOM if set, otherwise defaults to the standard Oh My Zsh path.
readonly ZSH_CUSTOM_PLUGINS_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins"
readonly FZF_INSTALL_DIR="${HOME}/.fzf"
readonly ZSH_FSH_THEME_INSTALL_DIR="${HOME}/.config"

# --- Helper Functions ---

# Prints a colored message.
# Globals:
#   COLOR_*
# Arguments:
#   1: The color code (e.g., ${COLOR_BOLD_GREEN}).
#   2: The message string.
function log_message() {
  local color="$1"
  local message="$2"
  echo -e "${color}${message}${COLOR_NC}"
}

# Ensures a required command is available in the PATH.
# Arguments:
#   1: The command name (e.g., 'git', 'curl').
function check_dependency() {
  local command_name="$1"
  if ! command -v "${command_name}" &>/dev/null; then
    log_message "${COLOR_RED}" "FATAL: '${command_name}' command not found. Please install ${command_name}." >&2
    exit 1
  fi
}

# Clones a git repository into a target directory.
# Arguments:
#   1: Repository URL.
#   2: Target directory path.
#   3: Optional: Any Git options (e.g., '--depth 1').
function install_plugin_git() {
  local repo_url="$1"
  local target_dir="$2"
  local depth_flag="${3:-}"
  local depth_value="${4:-}"
  local clone_successful=0

  if [[ -d "${target_dir}" ]]; then
    log_message "${COLOR_WHITE}" "  Skipping: ${target_dir} already exists."
    return 0
  fi

  log_message "${COLOR_WHITE}" "  Cloning repository: ${repo_url}"

  # Conditionally execute git clone based on whether depth arguments were provided.
  if [[ -n "${depth_flag}" ]] && [[ -n "${depth_value}" ]]; then
    # Execution for fzf: git clone --depth 1 [repo] [target]
    if git clone "${depth_flag}" "${depth_value}" "${repo_url}" "${target_dir}"; then
      clone_successful=1
    fi
  else
    # Execution for all others: git clone [repo] [target]
    if git clone "${repo_url}" "${target_dir}"; then
      clone_successful=1
    fi
  fi

  if [[ "${clone_successful}" -eq 1 ]]; then
    log_message "${COLOR_GREEN}" "  SUCCESS: Cloning complete."
  else
    log_message "${COLOR_RED}" "  ERROR: Failed to clone ${repo_url}. Check git permissions." >&2
    exit 1
  fi
}

# Installs Oh My Zsh via the standard installer, suppressing automatic shell change.
# Globals:
#   HOME
function install_oh_my_zsh() {
  log_message "${COLOR_BOLD_GREEN}" "1. Installing Oh My Zsh..."

  if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    log_message "${COLOR_WHITE}" "  Skipping: Oh My Zsh directory already exists."
    return 0
  fi

  # Set RUNZSH=no and CHSH=no to prevent the installer from running 'exec zsh',
  # which would stop the current script's execution.
  if sh -c "RUNZSH=no CHSH=no $(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
    log_message "${COLOR_GREEN}" "  SUCCESS: Oh My Zsh installation complete."
  else
    log_message "${COLOR_RED}" "  ERROR: Oh My Zsh installation failed." >&2
    exit 1
  fi
}

# --- Main Script Execution ---

log_message "${COLOR_BOLD_GREEN}" "--- Zsh Setup Started ---"

# Check primary dependencies
check_dependency "git"
check_dependency "curl"
check_dependency "sh"

# 1. Call OMZ Installation function
install_oh_my_zsh

# 2. Install fzf (Stand-alone utility)
log_message "${COLOR_BOLD_GREEN}" "2. Installing fzf (Command-Line Fuzzy Finder)..."

# Clones fzf with minimal history (depth 1)
install_plugin_git \
  "https://github.com/junegunn/fzf.git" \
  "${FZF_INSTALL_DIR}" \
  "--depth" \
  "1"

# Run fzf install script if installation succeeded
if [[ -d "${FZF_INSTALL_DIR}" ]]; then
  log_message "${COLOR_WHITE}" "  Running fzf install script..."
  if "${FZF_INSTALL_DIR}/install"; then
    log_message "${COLOR_GREEN}" "  SUCCESS: fzf configuration complete."
  else
    log_message "${COLOR_RED}" "  ERROR: fzf install script failed." >&2
    exit 1
  fi
fi

# 3. Install ZSH Plugins
log_message "${COLOR_BOLD_GREEN}" "3. Installing Zsh Plugins into custom directory..."

# 3a. zsh-autosuggestions
log_message "${COLOR_BOLD_GREEN}" "  a. Installing zsh-autosuggestions..."
install_plugin_git \
  "https://github.com/zsh-users/zsh-autosuggestions" \
  "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-autosuggestions"

# 3b. fast-syntax-highlighting
log_message "${COLOR_BOLD_GREEN}" "  b. Installing fast-syntax-highlighting and theme..."
install_plugin_git \
  "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" \
  "${ZSH_CUSTOM_PLUGINS_DIR}/fast-syntax-highlighting"
install_plugin_git \
  "https://github.com/catppuccin/zsh-fsh.git" \
  "${ZSH_FSH_THEME_INSTALL_DIR}/fsh/catppuccin"

# 3c. zsh-vi-mode
log_message "${COLOR_BOLD_GREEN}" "  c. Installing zsh-vi-mode..."
install_plugin_git \
  "https://github.com/jeffreytse/zsh-vi-mode" \
  "${ZSH_CUSTOM_PLUGINS_DIR}/zsh-vi-mode"

log_message "${COLOR_BOLD_GREEN}" "--- Zsh Setup Complete ---"
exit 0
