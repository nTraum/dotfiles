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
