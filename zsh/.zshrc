# Antigen
source /Users/ntraum/coding/zsh-users/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

antigen bundle bundler
antigen bundle git
antigen bundle jira
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

# Sublime Text 3
alias s="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

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

# JIRA URL
JIRA_URL="https://blacklane.atlassian.net"
