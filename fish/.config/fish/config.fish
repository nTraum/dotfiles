function is_lappen
    test "$hostname" = "lappen"
end

function add_ssh_key_if_missing
    set ssh_fingerprint $argv[1]
    set ssh_key = $argv[2]

    ssh-add -l | grep --quiet $ssh_fingerprint

    if test ! $status -eq 0
        echo "SSH key missing"
        ssh-add $ssh_key
    end
end

# Initializes sharship prompt
if command -v starship > /dev/null
    starship init fish | source
end

# Initializes asdf
if test -f ~/.asdf/asdf.fish > /dev/null
    source ~/.asdf/asdf.fish
end

# Abbreviations
abbr --add be bundle exec
abbr --add dc docker-compose
abbr --add g git
abbr --add gd git diff
abbr --add gds git diff --staged

set -xg EDITOR emacsclient

if status --is-interactive
    if is_bl_macbook
        add_ssh_key_if_missing aTXHZ7JAnuxsV1mkP4+2Iva2/w9xg4UaOJeJti2wpAY "$HOME/.ssh/id_ed25519"
        add_ssh_key_if_missing S/5A8aIh8BB6ergjWIKkQXQofMn9T73IglkrIN4smus "$HOME/.ssh/id_rsa"
    end

    if is_lappen
        add_ssh_key_if_missing IpoVpiDDh2UeWuXYJih2b0x77NnBfKxXCNieIcKZc8s "$HOME/.ssh/id_ed25519"
    end
end

if command -v fzf > /dev/null
    set -xg FZF_DEFAULT_OPTS '--height 40% --border'
    if command -v fd > /dev/null
        set -xg FZF_DEFAULT_COMMAND  'fd --type=file --hidden --no-ignore-vcs'
    end
end

if command -v bat > /dev/null
    alias cat="bat"

    function batf
        tail -f $argv | bat --paging=never -l log
    end
end
