function emacs_personal
    systemctl stop --user emacs
    ln -sfn ~/.emacs.d.pers ~/.emacs.d
    ln -sfn ~/.emacs.pers ~/.emacs
end

function emacs_spacemacs
    systemctl stop --user emacs
    ln -sfn ~/.emacs.d.spacemacs ~/.emacs.d
    unlink ~/.emacs
end
