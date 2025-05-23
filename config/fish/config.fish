if status --is-login
    # Set environment variables
    set -gx PNPM_HOME "/home/luiz/.local/share/pnpm"

    if not string match -q -- $PNPM_HOME $PATH
      set -gx PATH "$PNPM_HOME" $PATH
    end

    set -lx SHELL /usr/bin/fish
end

if status --is-interactive
    starship init fish | source
    direnv hook fish   | source

    # If keychain initialized the agents and added the keys previously, then
    # run in `quiet` mode.
    if keychain_started
        set quiet "--quiet"
    end

    set git_ssh_key github_tinyblk
    set gpg_key 5508FAC9F03AF83F

    if command -q keychain
        keychain $quiet --noinherit --eval $git_ssh_key $gpg_key | source
    end
end
