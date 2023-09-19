# Sources an env file
# Usage: envsource <path/to/env>

function envsource
  for line in (cat $argv | grep -v '^#' | grep -v '^\s*$')
    set item (string split -m 1 '=' $line)
    set -gx $item[1] $item[2]
    echo "Exported env var $item[1]"
  end
end
