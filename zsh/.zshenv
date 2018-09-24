# Custom aliases
alias nv="nvim"
alias pr="hub pull-request"
alias ct="rm -v ./tags; ctags ."
alias g="git"

# Elli aliases
alias reset_elli="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate"
alias reset_elli_with_test="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare"

# Ansible aliases
alias ap="ansible-playbook --vault-password-file ~/.vault_pass.txt"
alias av="ansible-vault --vault-password-file ~/.vault_pass.txt"

alias create_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\""
alias destroy_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\" -e \"state=absent\""

# Charles Proxy
function charles_enable {
  export HTTP_PROXY="http://127.0.0.1:8888"
  export HTTPS_PROXY="http://127.0.0.1:8888"
  export NO_PROXY="127.0.0.1:6258, 127.0.0.1:6263, 127.0.0.1:10191, 127.0.0.1:14821, 127.0.0.1:24861, 127.0.0.1:25007, 127.0.0.1:38151, 127.0.0.1:46360, 127.0.0.1:49801, 127.0.0.1:55730, 127.0.0.1:59483"
}

function charles_disable {
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset NO_PROXY
}

# fzf git checkout
fgc() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# GPG agent
export GPG_TTY=$(tty)
