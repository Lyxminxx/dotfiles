if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting
    alias ls='lsd'
    alias ll='lsd -alh'
    
    function fastfetch
    	echo ""
    	command fastfetch
    	echo ""
    	ls
    	echo ""
    end
    alias fetch='fastfetch'
end
