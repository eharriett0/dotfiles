#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(pwd)"

echo "Restoring dotfiles and CLI environment from: $DOTFILES_DIR"

# Restore dotfiles
DOTFILES=(
  .zshrc
  .bashrc
  .bash_profile
  .profile
  .gitconfig
  .vimrc
  .tmux.conf
  .inputrc
  .aliasrc
)

for file in "${DOTFILES[@]}"; do
  if [ -f "$DOTFILES_DIR/dotfiles/$file" ]; then
    cp "$DOTFILES_DIR/dotfiles/$file" "$HOME/$file"
    echo "✔ Restored $file"
  fi
done

# Restore .config directory
if [ -d "$DOTFILES_DIR/.config" ]; then
  mkdir -p "$HOME/.config"
  cp -r "$DOTFILES_DIR/.config/"* "$HOME/.config/"
  echo "✔ Restored .config"
fi

# Restore ~/bin
if [ -d "$DOTFILES_DIR/bin" ]; then
  mkdir -p "$HOME/bin"
  cp -r "$DOTFILES_DIR/bin/"* "$HOME/bin/"
  echo "✔ Restored ~/bin"
fi

# Restore Homebrew packages
if command -v brew &>/dev/null && [ -f "$DOTFILES_DIR/brew-packages.txt" ]; then
  echo "Restoring Homebrew packages..."
  xargs brew install < "$DOTFILES_DIR/brew-packages.txt"
  xargs brew tap < "$DOTFILES_DIR/brew-taps.txt"
fi

# Restore pip packages
if command -v pip &>/dev/null && [ -f "$DOTFILES_DIR/pip-requirements.txt" ]; then
  pip install -r "$DOTFILES_DIR/pip-requirements.txt"
  echo "✔ Restored pip packages"
fi

# Restore npm packages
if command -v npm &>/dev/null && [ -f "$DOTFILES_DIR/npm-packages.txt" ]; then
  echo "⚠️  Review and reinstall npm global packages manually from npm-packages.txt"
fi

# Restore iTerm2 Preferences
if [ -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" ]; then
  mkdir -p "$HOME/Library/Preferences"
  cp "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/"
  echo "✔ Restored iTerm2 preferences"
  echo "⚠️  Make sure iTerm2 is set to load preferences from: $DOTFILES_DIR/iterm2"
fi

# Notify for cargo and asdf
echo "⚠️  Please reinstall cargo packages manually using: cargo install --list"
echo "⚠️  Please reinstall asdf plugins and versions using: asdf-versions.txt"

echo "✅ Dotfiles and environment restored."