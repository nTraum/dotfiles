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

# Open file in a running emacs session
alias em="emacsclient --no-wait"

set -xg EDITOR emacsclient

# FZF
if command -v fzf > /dev/null
    set -xg FZF_DEFAULT_OPTS '--height 40% --border'
    if command -v fd > /dev/null
        set -xg FZF_DEFAULT_COMMAND  'fd --type=file --hidden --no-ignore-vcs'
    end

    function gcf
        git checkout (git branch --all | sed "s/.* //" | fzf)
    end
end

# bat as a cat replacement
if command -v bat > /dev/null
    alias cat="bat"

    function batf
        tail -f $argv | bat --paging=never -l log
    end
end

# `tm` alias to attach to running tmux session or create a new one
if command -v tmux > /dev/null
    function tm -d "Attach to running tmux session or create a new one"
        tmux attach || tmux new
    end
end

# Start / attach to tmux if we are not in a tmux session already
if not set --query TMUX
    tm
end
