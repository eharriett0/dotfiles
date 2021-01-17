#!/bin/bash

# homebrew 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec $SHELL

brew update 

# iterm2
brew install --cask iterm2

# everything else (casks)
brew install --cask notion zoomus brave-browser-dev visual-studio-code	\
    spotify rectangle firefox-developer-edition wire discord \
    nordvpn

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
brew install openssl readline sqlite3 xz zlib

curl -L https://get.oh-my.fish | fish

