set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim

alias vi=nvim
alias vim=nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

