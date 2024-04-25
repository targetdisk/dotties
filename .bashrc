#!/usr/bin/env bash

simplefind() { find . -iname '*'"$@"'*'; }
simpleplay() {
  find . -iname '*'"$@"'*' -print0 \
    | xargs -0 mpv --no-audio-display \
  ;
}

command -v uname >/dev/null &&
  case $(uname) in
    Darwin)
      command -v port >/dev/null && . /opt/local/etc/bashrc.mac
      ;;
    FreeBSD)
      [[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] \
        && . /usr/local/share/bash-completion/bash_completion.sh
      ;;
  esac \
;
