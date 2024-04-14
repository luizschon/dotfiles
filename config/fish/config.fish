if status --is-login

    # Set environment variables
    set -g -x EDITOR nvim

    # Start window manager after login, display managers are having problems
    # starting a Xorg session.
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end

end

if status is-interactive
    starship init fish | source

    # Start ssh-agent (this is bad, as the agent runs forever unchecked)
    if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
end
