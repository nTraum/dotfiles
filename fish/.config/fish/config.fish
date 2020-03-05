source ~/.asdf/asdf.fish

abbr --add g git
abbr --add gd git diff
abbr --add gds git diff --staged

abbr --add be bundle exec



alias saml_p='saml2aws login -a production -p production'
alias saml_t='saml2aws login -a testing -p testing'

abbr --add apc "saml_t; env AWS_PROFILE=testing STACK_NAME=phili pipenv run ansible-playbook -i aws.py -e 'stack_name=phili' --vault-password-file ~/ansible_vault.txt"

alias create_my_stack="saml_t; env AWS_PROFILE=testing pipenv run ansible-playbook aws_infrastructure.yml -e 'stack_name=phili key_pair=philipp' --vault-password-file ~/ansible_vault.txt"

alias destroy_my_stack="saml_t; env AWS_PROFILE=testing pipenv run ansible-playbook aws_infrastructure.yml -e 'stack_name=phili key_pair=philipp state=absent' --vault-password-file ~/ansible_vault.txt"

set -xg GTAGSLABEL pygments
set -xg EDITOR emacsclient

if status --is-interactive
    if ssh-add -l | grep --quiet aTXHZ7JAnuxsV1mkP4+2Iva2/w9xg4UaOJeJti2wpAY
        echo "SSH key already added to ssh agent."
    else
        echo "SSH key not added to ssh-agent yet, adding..."
        ssh-add $HOME/.ssh/id_ed25519
    end

    if ssh-add -l | grep --quiet S/5A8aIh8BB6ergjWIKkQXQofMn9T73IglkrIN4smus
        echo "SSH key already added to ssh agent."
    else
        echo "SSH key not added to ssh-agent yet, adding..."
        ssh-add $HOME/.ssh/id_rsa
    end
end

function reset_elli_with_test
    mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare
end
