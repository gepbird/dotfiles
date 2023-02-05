#!/bin/zsh

read_confirm() {
  while true; do
    echo "$1 [y/N]"
    read confirm
    case $confirm in
      Y) return 0;;
      y) return 0;;
      *) return 1;;
    esac
  done
}

link() {
  SCRIPT_DIR=${0:a:h}
  source_path="$SCRIPT_DIR/home/$1"
  if test -n "$2"; then # super user
    target_path="/root/$1"
  else                  # normal user
    target_path="/home/$USER/$1"
  fi

  if sudo test -L $target_path; then # is symlink
    if test -n "$2"; then
      sudo rm $target_path
    else
      rm $target_path
    fi
  fi

  if test -e $target_path; then # exists
    if read_confirm "Do you want to delete $target_path?"; then
      rm -rf $target_path
    else
      return 1
    fi
  fi

  if test -n "$2"; then
    sudo mkdir -vp $(dirname $target_path)
    sudo ln -vsf $source_path $target_path
  else 
    mkdir -vp $(dirname $target_path)
    ln -vsf $source_path $target_path
  fi
}

link $@
