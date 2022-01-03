#!/bin/fish

function read_confirm
  while true
    read -l -P "$argv[1] [y/N] " confirm
    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end

function link
  set SCRIPT_DIR (cd (dirname (status --current-filename)); and pwd)
  set setup "$SCRIPT_DIR/home/$argv[1]"
  set home "/home/$USER/$argv[1]"

  if test -e $home && ! test -L $home # exists and not a symlink
    if read_confirm "Do you want to delete $home?"
      rm -rf $home
    else
      return 1
    end
  end
  ln -vsf $setup $home
end

link $argv[1]
