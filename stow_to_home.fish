# Stows all directories to $HOME

set STOWS asdf emacs fish git psql rclone ripgrep ssh starship terminator tmux neovim

echo Stowing the following directories to $HOME:
echo 📁 $STOWS
read -l -P 'Do you want to continue? [y/N]: ' confirm

switch $confirm
    case Y y yes
    case '' N n no
        echo "Exiting..."
        exit 1
end

for dir in $STOWS
    echo -n Stowing $dir
    stow $dir --target=$HOME
    echo " ✅"
end
