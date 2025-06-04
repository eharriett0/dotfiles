# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

set -gx PATH $PATH $HOME/.krew/bin

source ~/.aliasrc

# opam configuration
source /Users/quelo/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true