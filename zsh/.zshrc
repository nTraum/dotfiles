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
antigen bundle nojhan/liquidprompt

antigen theme agnoster

antigen apply

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# z (https://github.com/rupa/z)
. `brew --prefix`/etc/profile.d/z.sh

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

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

# liquidprompt configuration
LP_ENABLE_BATT="false"
LP_ENABLE_SSH_COLORS="false"

LP_ENABLE_BZR="false"
LP_ENABLE_FOSSIL="false"
LP_ENABLE_HG="false"
LP_ENABLE_SVN="false"

LP_RUNTIME_THRESHOLD=10

# QT 5
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

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

# assh
export ASSH_PLAYBOOKS_DIRECTORY="${HOME}/coding/blacklane/ansible-playbooks"
source "${HOME}/coding/blacklane/dotfiles/assh.sh"
source "${HOME}/coding/blacklane/dotfiles/release.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
