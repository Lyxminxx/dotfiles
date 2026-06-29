if status is-interactive
    set fish_greeting ""
    alias ls lsd
    alias ll 'lsd -l'
    alias la 'lsd -al'
    alias pac 'eval $(poetry env activate)'
    alias notes 'hx ~/Documents/notes.md'
    alias cat bat
    set -U fish_user_paths $GOPATH/bin $HOME/.local/bin $fish_user_paths
    export SUDO_EDITOR=hx
end
starship init fish | source
