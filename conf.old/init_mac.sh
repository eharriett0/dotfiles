#!/bin/bash

# homebrew 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec $SHELL

brew update && brew upgrade

# get nordpass
curl -v https://downloads.npass.app/mac/NordPass.dmg --output "~/NordPass.dmg"

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

# fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
curl -L https://get.oh-my.fish | fish
fisher install IlanCosman/tide


