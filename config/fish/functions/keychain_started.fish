function keychain_started
    set pid_file "$HOME/.keychain/$hostname-fish"

    # Source keychain PIDFILE env variables
    if test -f $pid_file
        source $pid_file
    end

    # Check is ssh-agent was loaded previously
    if test -n "$SSH_AUTH_SOCK"
        if ssh-add -l > /dev/null 2>&1
            return 0
        end
    end
    return 1
end
