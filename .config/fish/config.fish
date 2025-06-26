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
end
