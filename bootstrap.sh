#!/bin/bash

set -euo pipefail

echo "🚀 Bootstrapping your CLI environment..."

# --- 1. Install Homebrew (if not already installed) ---
if ! command -v brew &>/dev/null; then
  echo "🔧 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew already installed"
fi

# --- 2. Install Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🔧 Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh already installed"
fi

# --- 3. Install Starship ---
if ! command -v starship &>/dev/null; then
  echo "🔧 Installing Starship prompt..."
  brew install starship
else
  echo "✅ Starship already installed"
fi

# --- 4. Install kube-ps1 ---
if ! brew list kube-ps1 &>/dev/null; then
  echo "🔧 Installing kube-ps1..."
  brew install kube-ps1
else
  echo "✅ kube-ps1 already installed"
fi

# --- 5. Install asdf ---
if [ ! -d "$HOME/.asdf" ]; then
  echo "🔧 Installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  echo '. "$HOME/.asdf/asdf.sh"' >> ~/.zshrc
  echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.zshrc
  echo "✅ Added asdf to .zshrc (you may need to restart your shell)"
else
  echo "✅ asdf already installed"
fi

# --- 6. Remind about iTerm2 prefs ---
echo "⚠️  Make sure iTerm2 is set to load preferences from your dotfiles repo: ~/engineering/general_dev/dotfiles/iterm2"

echo "🎉 Bootstrap complete. Run 'exec zsh' or restart your terminal to see changes."