if status --is-login
    # Set environment variables
    set -g -x EDITOR zed
    # set -gx GPG_TTY (tty)
end

if status --is-interactive
    starship init fish | source

    set -lx SHELL /usr/bin/fish

    set git_ssh_key github_tinyblk
    set gpg_key 5508FAC9F03AF83F

    if command -q keychain
        keychain --quiet --eval --agents ssh,gpg $git_ssh_key $gpg_key | source
    end

    if test "$TERM_PROGRAM" = "WezTerm"; and command -q fastfetch
        fastfetch --gpu-hide-type integrated
        echo ""
    end
end
