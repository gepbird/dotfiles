TERMINAL='st'
EDITOR='nvim'
PATH="$PATH:$HOME/.local/bin"

# History
HISTFILE=$HOME/.cache/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
#setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
#setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt INC_APPEND_HISTORY

# Built in autocomplete
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Starship
eval "$(starship init zsh)"

export GPG_TTY=$(tty)

# Completion menu navigation
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history

# Use lf to switch directories and bind it to ctrl-o
cf () {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}

# Plugins

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

source /etc/profile.d/autojump.zsh

# Vi mode and plugin
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
bindkey -v
export KEYTIMEOUT=1
ZVM_VI_HIGHLIGHT_BACKGROUND=#264F78
zvm_bindkey viins '^l' end-of-line
zvm_bindkey vicmd '^l' end-of-line
zvm_bindkey viins '^h' beginning-of-line
zvm_bindkey vicmd '^h' beginning-of-line
zvm_bindkey vicmd 'e' vi-history-search-backward
# Fix end key
zvm_bindkey viins '^[[4~' end-of-line
zvm_bindkey vicmd '^[[4~' end-of-line

# Override default commands
alias ls='exa --color=always --group-directories-first --icons'
alias cat='bat --style rule --style snip --style changes --style header'
alias grep='rg -i --color=auto'

# Aliases
alias pacf='paru -Ss'
pacff () { paru -Ss $1 | grep $1 }
pacfi () { paru -Ss $1 | grep Installed | grep $1 }
alias paci='paru -S --noconfirm --needed'
alias pacI='paru -S --needed'
alias pacr='sudo paru -Rs --noconfirm'
alias pacrr='sudo paru -Rns --noconfirm'
alias pacu='sudo pacman -Syyu; paru -Su; dvm update stable'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias rip='expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'

alias sysi='systemctl status'
alias sysr='sudo systemctl restart'
alias sysl='sudo systemctl start'
alias syss='sudo systemctl stop'
alias syse='sudo systemctl enable --now'
alias sysE='sudo systemctl enable'
alias sysd='sudo systemctl disable --now'
alias sysD='sudo systemctl disable'
alias jouri='journalctl -u'
alias joure='journalctl -xeu'

alias v='nvim'
alias g='git'
alias la='ls -la'
alias lff='ls -la | grep'
alias ff='find | grep'
alias hisf='history | grep'
alias rmf='sudo rm -rf'
alias zshreload='source ~/.zshrc'
alias clip='xclip -selection clipboard'
alias dnd='dragon-drop --and-exit --all'
alias getpid='xdotool getwindowpid $(xdotool selectwindow)'
alias whatsmyip='curl ifconfig.me'
alias pickcolor='colorpicker --one-shot --preview --short'
alias clipcolor='colorpicker --one-shot --preview --short | xclip -selection clipboard'
alias sk='screenkey --timeout 2 --font-size small --key-mode raw --mouse'
alias nosk='killall screenkey'
cpbak() { cp -r $1 $1.bak }
mvbak() { mv $1 $1.bak }

github-ssh() {
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
  if command -v xdg-open > /dev/null; then
    xdg-open 'https://github.com/settings/ssh/new'
    echo 'Opened github in browser'
  fi
  echo 'Add the ssh key below to github via https://github.com/settings/ssh/new'
  echo '-----BEGIN SSH PUBLIC KEY BLOCK-----'
  bat --style snip ~/.ssh/id_ed25519.pub
  echo '------END SSH PUBLIC KEY BLOCK------'
  if command -v xclip > /dev/null; then
    cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
    echo 'Copied ssh key to clipboard'
  fi
}

github-gpg() {
  gpg --full-gen-key
  if command -v xdg-open > /dev/null; then
    xdg-open 'https://github.com/settings/gpg/new'
    echo 'Opened github in browser'
  fi
  echo 'Add the gpg key below to github via https://github.com/settings/gpg/new'
  gpg --armor --export
  if command -v xclip > /dev/null; then
    gpg --armor --export | xclip -selection clipboard
    echo 'Copied gpg key to clipboard'
  fi
}
