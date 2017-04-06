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
alias pr="hub pull-request"

# Elli aliases
alias reset_elli="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate"
alias reset_elli_with_test="mysql -uroot < db/reset_db.sql; bundle exec rake db:migrate test:prepare"

# Ansible aliases
alias ap="ansible-playbook --vault-password-file ~/.vault_pass.txt"
alias av="ansible-vault --vault-password-file ~/.vault_pass.txt"

alias create_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\""
alias destroy_my_stack="ap aws_infrastructure.yml -e \"stack_name=philipp\" -e \"key_pair=philipp.press\" -e \"state=absent\""

# Brew go
export GOPATH=/Users/ntraum/go
export PATH=$PATH:/usr/local/opt/go/libexec/bin

# Set neovim as default editor
export EDITOR=nvim
export VISUAL=nvim

# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
