#!/bin/bash

# homebrew 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec $SHELL

brew update 

# iterm2
brew install --cask iterm2

# everything else (casks)
brew install --cask notion
brew install --cask zoomus
brew install --cask brave-browser-dev
brew install --cask visual-studio-code	
brew install --cask spotify
brew install --cask rectangle
brew install --cask firefox-developer-edition
brew install --cask wire
brew install --cask discord
brew install --cask nordvpn

# go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"
brew install go
exec $SHELL
go get golang.org/x/tools/cmd/godoc
go get github.com/golang/lint/golint

# rust development
curl https://sh.rustup.rs -sSf | sh
exec $SHELL
source $HOME/.cargo/env

# other tools
brew install exa ripgrep bat
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install fish
curl -L https://get.oh-my.fish | fish

