#!/usr/bin/env bash

HISTSIZE=10000
HISTFILESIZE=900000

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty*)
    PS1='\033]2;Terminal: \h:\W \u\007\h:\[\033[38;5;219m\]\W\[\033[00m\] \[\033[01;35m\]\u\[\033[00m\]\$ '
    ;;
  *)
    PS1='\h:\W \u\$ '
    ;;
esac

simplefind() { find . -iname '*'"$@"'*'; }
simpleplay() {
  find . -iname '*'"$@"'*' -print0 \
    | xargs -0 mpv --no-audio-display \
  ;
}

command -v uname >/dev/null &&
  case $(uname) in
    Linux)
      alias ls='ls --color'
      [ -f /etc/os-release ] && . /etc/os-release
      ;;
    Darwin)
      command -v port >/dev/null && . /opt/local/etc/bashrc.mac
      ;;
    FreeBSD)
      [[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] \
        && . /usr/local/share/bash-completion/bash_completion.sh

      . "$HOME/.bashrc.freebsd"
      ;;
  esac \
;
