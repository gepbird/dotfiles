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
  if test -n "$argv[2]" # super user
    set setup "/home/$USER/$argv[1]"
    set home "/root/$argv[1]"
  else # normal user
    set setup "$SCRIPT_DIR/home/$argv[1]"
    set home "/home/$USER/$argv[1]"
  end

  if test -e $home && ! test -L $home # exists and not a symlink
    if read_confirm "Do you want to delete $home?"
      rm -rf $home
    else
      return 1
    end
  end

  if test -n "$argv[2]"
    sudo mkdir -vp (dirname $home)
    sudo ln -vsf $setup $home
  else
    mkdir -vp (dirname $home)
    ln -vsf $setup $home
  end
end

link $argv
