#!/usr/bin/env bash

command -v port >/dev/null &&
    command -v uname >/dev/null &&
    [ $(uname) == 'Darwin' ] &&  . /opt/local/etc/bashrc.mac

simplefind() { find . -iname '*'"$@"'*'; }
simpleplay() {
  find . -iname '*'"$@"'*' -print0 \
    | xargs -0 mpv --no-audio-display \
  ;
}
