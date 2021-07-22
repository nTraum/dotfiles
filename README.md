# nTraum's dotfiles

Personal dotfiles, feel free to take a look.
If you don't want to manage symlinks manually, take a look at [stow](https://www.gnu.org/software/stow/manual/stow.html).

## Requirements

- stow

## Usage

`stow_to_home.fish` is a script that stows all directories to `$HOME`.

```shell
$ fish stow_to_home.fish
Stowing the following directories to /home/ntraum:
📁 asdf emacs fish git psql ripgrep starship terminator
Do you want to continue? [y/N]: y
Stowing asdf ✅
Stowing emacs ✅
Stowing fish ✅
Stowing git ✅
Stowing psql ✅
Stowing ripgrep ✅
Stowing starship ✅
Stowing terminator ✅
```

## LICENSE

MIT
