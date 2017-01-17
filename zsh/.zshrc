# Antigen
source /Users/ntraum/coding/zsh-users/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle bundler
antigen bundle git
antigen bundle mix-fast
antigen bundle rake-fast
antigen bundle redis-cli
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme agnoster

antigen apply

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# z (https://github.com/rupa/z)
. `brew --prefix`/etc/profile.d/z.sh

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f /Users/ntraum/.travis/travis.sh ] && source /Users/ntraum/.travis/travis.sh

# Brew
export PATH="/usr/local/sbin:$PATH"

# ~/bin
export PATH="$HOME/bin:$PATH"

# awscli
source /usr/local/share/zsh/site-functions/_aws

# direnv
eval "$(direnv hook zsh)"

# Automatically list directory contents on `cd`.
auto-ls () { ls; }
chpwd_functions=( auto-ls $chpwd_functions )

# Hide default user in prompt (agnoster theme)
DEFAULT_USER="ntraum"

# Custom aliases
alias nv="nvim"

# Elli aliases
alias reset_elli="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate"
alias reset_elli_with_test="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare"

# Ansible aliases
alias ap="ansible-playbook --vault-password-file ~/.vault_pass.txt"
alias av="ansible-vault --vault-password-file ~/.vault_pass.txt"

# Brew go
export GOPATH=/Users/ntraum/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Set neovim as default editor
export EDITOR=nvim
export VISUAL=nvim
