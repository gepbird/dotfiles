set TERMINAL st
set EDITOR nvim
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
fish_add_path $HOME/.local/bin

if status --is-interactive
  source ("/usr/bin/starship" init fish --print-full-init | psub)
end

fish_vi_key_bindings

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

function history
  builtin history --show-time='%F %T '
end

function backup --argument filename
  cp -r $filename $filename.bak
end

alias grep='rg -i --color=auto'
alias cat='bat --style rule --style snip --style changes --style header'
alias lf='lfrun'

alias ls='exa --color=always --group-directories-first --icons'
alias la='ls -la'                                               # all files and dirs
alias lt='ls -aT'                                               # tree listing
alias lff='la | grep'                                           # list and find

alias pacf='paru -Ss'
function pacff
  paru -Ss $argv[1] | grep $argv[1]
end
function pacfi
  paru -Ss $argv[1] | grep Installed | grep $argv[1]
end
alias paci='paru -S --noconfirm --needed'
alias pacI='paru -S --needed'
alias pacr='paru -Rs --noconfirm'
alias pacrr='paru -Rns --noconfirm'
alias pacu='paru -Syyu'
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

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
alias ff='find | grep'
alias hisf='history | grep'
alias rmf='sudo rm -rf'
alias fishreload='source ~/.config/fish/config.fish'
alias wget='wget -c '
alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions && sudo updatedb'
alias hw='hwinfo --short'
alias chgep='sudo chown -R $USER:$USER'
alias clip='xclip -selection clipboard'
alias java-upgrade='sudo ln -vsf /bin/java-18 /bin/java'
alias java-downgrade='sudo ln -vsf /bin/java-8 /bin/java'
alias dnd='dragon-drop --and-exit --all'
alias getpid='xdotool getwindowpid $(xdotool selectwindow)'
alias whatsmyip='curl ifconfig.me'

function ssh-make-key
  read -P 'Enter email: ' email
  ssh-keygen -t ed25519 -C $email
  bash -c 'eval "$(ssh-agent -s)"'
  ssh-add ~/.ssh/id_ed25519
  set ssh_add_link 'https://github.com/settings/ssh/new'
  xdg-open $ssh_add_link
  echo "Add it to github via $ssh_add_link"
  echo "------------- PUBLIC KEY --------------"
  bat --style snip ~/.ssh/id_ed25519.pub
  echo "---------- END OF PUBLIC KEY ----------"
  cat ~/.ssh/id_ed25519.pub | clip
  echo "Public key copied to clipboard"
end
