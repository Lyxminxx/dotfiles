if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias ll='lsd -alh'

    function fastfetch
        echo ""
        command fastfetch
        echo ""
        lsd
        echo ""
    end
    alias fetch='fastfetch'
    alias ls='lsd -a'
    alias vim='nvim'
end
export GTK_THEME=MonoThemeDark
set -x GTK_ICON_THEME besgnulinux-mono-grey

# Created by `pipx` on 2025-06-27 10:45:24
set PATH $PATH /home/madelen/.local/bin
