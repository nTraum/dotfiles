function cl_epic_logs --description "Show logs for epic deployment" --argument-names epic_name
    if test -z $epic_name
        echo "No epic name specified."
        echo "Usage: ci_epic_logs EPIC_NAME"
        return 1
    end

    ssh do-epics "docker logs \$(docker ps | grep $epic_name | tr -s ' ' | cut -d ' ' -f1) --follow"
end
