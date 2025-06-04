#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$(pwd)"

echo "Backing up dotfiles and CLI setup into: $DOTFILES_DIR"

# Core dotfiles
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

mkdir -p "$DOTFILES_DIR/dotfiles"
for file in "${DOTFILES[@]}"; do
  if [ -f "$HOME/$file" ]; then
    cp "$HOME/$file" "$DOTFILES_DIR/dotfiles/"
    echo "✔ Copied $file"
  fi
done

# .config (for nvim, starship, etc.)
mkdir -p "$DOTFILES_DIR/.config"
cp -r "$HOME/.config"/* "$DOTFILES_DIR/.config/" 2>/dev/null || echo "⚠️  No .config files found"

# ~/bin
if [ -d "$HOME/bin" ]; then
  mkdir -p "$DOTFILES_DIR/bin"
  cp -r "$HOME/bin" "$DOTFILES_DIR/"
  echo "✔ Copied ~/bin"
fi

# Homebrew
if command -v brew &>/dev/null; then
  brew list > "$DOTFILES_DIR/brew-packages.txt"
  brew tap > "$DOTFILES_DIR/brew-taps.txt"
  echo "✔ Saved Homebrew packages"
fi

# pip
if command -v pip &>/dev/null; then
  pip freeze > "$DOTFILES_DIR/pip-requirements.txt"
  echo "✔ Saved pip packages"
fi

# npm
if command -v npm &>/dev/null; then
  npm list -g --depth=0 > "$DOTFILES_DIR/npm-packages.txt"
  echo "✔ Saved npm global packages"
fi

# cargo
if command -v cargo &>/dev/null; then
  cargo install --list > "$DOTFILES_DIR/cargo-packages.txt"
  echo "✔ Saved Rust cargo installs"
fi


# asdf
if command -v asdf &>/dev/null; then
  asdf list > "$DOTFILES_DIR/asdf-versions.txt"
  echo "✔ Saved asdf versions"
fi

# iTerm2 Preferences
if [ -f "$HOME/Library/Preferences/com.googlecode.iterm2.plist" ]; then
  mkdir -p "$DOTFILES_DIR/iterm2"
  cp "$HOME/Library/Preferences/com.googlecode.iterm2.plist" "$DOTFILES_DIR/iterm2/"
  echo "✔ Backed up iTerm2 preferences"
fi

echo "✅ Dotfiles and environment saved. Commit this repo and push to reuse on a new machine."