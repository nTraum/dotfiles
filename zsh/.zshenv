# Custom aliases
alias nv="nvim"
alias pr="hub pull-request"
alias ct="rm -v ./tags; ctags ."

# Elli aliases
alias reset_elli="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate"
alias reset_elli_with_test="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare"

# Ansible aliases
alias ap="ansible-playbook --vault-password-file ~/.vault_pass.txt"
alias av="ansible-vault --vault-password-file ~/.vault_pass.txt"

alias create_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\""
alias destroy_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\" -e \"state=absent\""

