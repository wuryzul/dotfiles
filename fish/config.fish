babelfish < $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh | source

set fish_greeting
set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -gx DIRENV_LOG_FORMAT ""

alias vi=nvim
alias vim=nvim
alias ll="ls -l"
alias la="ls -la"

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source
end

