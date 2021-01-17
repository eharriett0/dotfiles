# Defined in - @ line 1
function ls --wraps='exa --grid --color=always --icons' --description 'alias ls=exa --grid --color=always --icons'
  exa --grid --color=always --icons $argv;
end