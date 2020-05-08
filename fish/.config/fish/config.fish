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

set -xg EDITOR emacsclient

function is_lappen
    test "$hostname" = "lappen"
end

function is_bl_macbook
    test "$hostname" = "BLSOMETHINGSOMETHING"
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

if status --is-interactive
    if is_bl_macbook
	add_ssh_key_if_missing aTXHZ7JAnuxsV1mkP4+2Iva2/w9xg4UaOJeJti2wpAY "$HOME/.ssh/id_ed25519"
	add_ssh_key_if_missing S/5A8aIh8BB6ergjWIKkQXQofMn9T73IglkrIN4smus "$HOME/.ssh/id_rsa"
    end

    if is_lappen
	add_ssh_key_if_missing hQqd2Fu/jyNBVHPNFZC35rdn2EZdDzkxzRe9RM1wa2M "$HOME/.ssh/id_ed25519"
    end
end

function reset_elli_with_test
    mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare
end

if command -v starship
    starship init fish | source
end
