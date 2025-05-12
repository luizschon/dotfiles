if status --is-login
    # Set environment variables
end

if status --is-interactive
    starship init fish | source

    set -lx SHELL /usr/bin/fish

    set git_ssh_key github_tinyblk
    set gpg_key 5508FAC9F03AF83F

    if command -q keychain
        keychain --quiet --eval $git_ssh_key $gpg_key | source
    end

    if test "$TERM_PROGRAM" = "WezTerm"; and command -q fastfetch
        fastfetch --gpu-hide-type integrated
        echo ""
    end

    direnv hook fish | source
end

# pnpm
set -gx PNPM_HOME "/home/luiz/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
