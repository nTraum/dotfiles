# Sources an env file
# Usage: envsource <path/to/env>

# https://fishshell.com/docs/current/language.html#variable-scope
#
# There are four kinds of variables in fish: universal, global, function and local variables.
#
# Universal variables are shared between all fish sessions a user is running on one computer. They are stored on disk and persist even after reboot.
# Global variables are specific to the current fish session. They can be erased by explicitly requesting set -e.

function envsource
  # Ignore commented
  for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
    set item (string split -m 1 '=' $line)
    #set -gx $item[3] $item[2]
     set -Ux $item[1] $item[2]
    echo "Exported universal env var $item[1]"
  end
end
