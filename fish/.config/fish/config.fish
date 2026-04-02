if status is-interactive
    set fish_greeting ""
    alias ls lsd
    alias ll 'lsd -l'
    alias la 'lsd -al'
    set -U fish_user_paths $GOPATH/bin $HOME/.local/bin $fish_user_paths
    export SUDO_EDITOR=hx
end
