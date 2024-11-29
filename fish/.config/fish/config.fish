fish_add_path /opt/nvim-linux64/bin

# Initializes sharship prompt
if command -v starship > /dev/null
    starship init fish | source
end

# Initializes asdf
if test -f ~/.asdf/asdf.fish > /dev/null
    source ~/.asdf/asdf.fish
end

# Abbreviations
abbr --add ... cd ../..
abbr --add .... cd ../../..
abbr --add ..... cd ../../../..
abbr --add / cd /
abbr --add be bundle exec
abbr --add dc docker-compose
abbr --add g git
abbr --add gd git diff
abbr --add gds git diff --staged
abbr --add lg lazygit
abbr --add mc mix compile
abbr --add mp mkdir --parents
abbr --add mt MIX_ENV=test mix test
abbr --add mts MIX_ENV=test mix test --stale
abbr --add nv nvim

# Open file in a running emacs session
alias em="emacsclient --no-wait"
set -xg EDITOR "nvim"

if command -v eza > /dev/null
    alias l="eza -l --icons"
    alias la="eza -la --icons"
end

# FZF
if command -v fzf > /dev/null
    # Default Fish keybindings
    set -xg FZF_DEFAULT_OPTS '--height 40% --border'

    if command -v fd > /dev/null
        set -xg FZF_DEFAULT_COMMAND  'fd --type=file --hidden --no-ignore-vcs'
    end

    fzf --fish | source

    # Bind Ctrl+G to insert git branch via fzf
    bind \cg 'commandline -i $(git branch --sort=-committerdate | grep -v "^\\*" | tr -d "[:blank:]" | fzf --height=20% --reverse --info=inline); commandline -f repaint'

    # Bind Ctrl+Alt+S to insert git status file via fzf
    bind \e\cS 'commandline -i $(git -c color.status=always status --short | fzf --ansi --no-sort | fzf --ansi --no-sort | awk \'{print $NF}\'); commandline -f repaint'


    # TODO bind this to ctrl + alt + s
    # git -c color.status=always status --short | fzf --ansi --no-sort | awk '{print $NF}'
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

if command -v podman > /dev/null
  alias docker=podman
end
