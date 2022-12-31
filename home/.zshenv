export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export _JAVA_AWT_WM_NONREPARENTING=1 # fix java apps blank screen
export GTK_THEME=Adwaita:dark # for GTK 3 and 4 apps
export QT_QPA_PLATFORMTHEME=gtk2 # for Qt 5 and 6 apps

export TERMINAL='st'
export EDITOR='nvim'

export PATH="$PATH:$HOME/.local/bin"
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export ZSH_COMPDUMP=$XDG_CACHE_HOME/.zcompdump
