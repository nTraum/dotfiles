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

# bat (cat replacement)
if command -v bat > /dev/null
    alias cat="bat"

    function batf
        tail -f $argv | bat --paging=never -l log
    end
end

# CitizenLab

function cl_ci_build --description="Triggers a full CI build" --argument-names git_branch
    if test -z $git_branch
        echo "No git branch specified, checking current working directory..."
        set git_branch (git branch --show-current)
    end

    if test -z $git_branch
        echo "No git branch found in current working directory. Either specify a git branch or run the command in directory with a git repository."
        echo "Usage: cl_ci_build <BRANCH>"
        return 1
    end

    echo "Triggering build for $git_branch"
    curl \
        --request POST \
        -u $CIRCLE_CI_TOKEN: \
        --url https://circleci.com/api/v2/project/github/CitizenLabDotCo/citizenlab/pipeline \
        --header 'content-type: application/json' \
        --data "{\"branch\": \"$git_branch\",\"parameters\": {\"trigger\": false,  \"back\": true, \"front\": false}}"
end

function cl_epic_logs --description "Show logs for epic deployment" --argument-names epic_name
    if test -z $epic_name
        echo "No epic name specified."
        echo "Usage: ci_epic_logs EPIC_NAME"
        return 1
    end

    ssh do-epics "docker logs \$(docker ps | grep $epic_name | tr -s ' ' | cut -d ' ' -f1) --follow"
end
