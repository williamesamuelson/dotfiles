#!/bin/bash

# Define dotfiles directory
DOTFILES_DIR="$HOME/dotfiles/config"

# Create symlinks
create_symlink() {
  local target="$1"
  local link="$2"

  if [[ -L "$link" ]]; then
    echo "Symlink already exists: $link"
  elif [[ -e "$link" ]]; then
    echo "File or directory already exists at $link, skipping."
  else
    echo "Creating symlink: $link -> $target"
    mkdir -p "$(dirname "$link")"  # Ensure the parent directory exists
    ln -s "$target" "$link"
  fi
}

# Define the symlinks
declare -a SYMLINKS=(
  "$DOTFILES_DIR/julia/startup.jl:$HOME/.julia/config/startup.jl"
  "$DOTFILES_DIR/git/gitconfig:$HOME/.gitconfig"
  "$DOTFILES_DIR/tmux/tmux.conf:$HOME/.tmux.conf"
  "$DOTFILES_DIR/zsh/zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/zsh/zprofile:$HOME/.zprofile"
  "$DOTFILES_DIR/nvim:$HOME/.config/nvim"
  "$DOTFILES_DIR/wezterm:$HOME/.config/wezterm"
)

# Iterate over the symlinks and create them
for pair in "${SYMLINKS[@]}"; do
  target="${pair%%:*}"
  link="${pair##*:}"
  create_symlink "$target" "$link"
done

echo "Symlinks setup complete!"

