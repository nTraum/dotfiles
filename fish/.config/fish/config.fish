source ~/.asdf/asdf.fish

abbr --add g git
abbr --add gd git diff
abbr --add gds git diff --staged

abbr --add be bundle exec

set -xg GTAGSLABEL pygments
set -xg EDITOR emacsclient

if status --is-interactive
    if ssh-add -l | grep --quiet hQqd2Fu/jyNBVHPNFZC35rdn2EZdDzkxzRe9RM1wa2M
        echo "SSH key already added to ssh agent."
    else
        echo "SSH key not added to ssh-agent yet, adding..."
        ssh-add $HOME/.ssh/id_ed25519
    end
end
