command -v port >/dev/null &&
    command -v uname >/dev/null &&
    [ $(uname) == 'Darwin' ] && . .bashrc.mac

simplefind() { find . -iname '*'"$@"'*'; }
simpleplay() {
  find . -iname '*'"$@"'*' -print0 \
    | xargs -0 mpv --no-audio-display \
  ;
}

# Python
alias mk-venv='python -m venv .venv'
alias do-venv='. .venv/bin/activate'
alias rm-venv='rm -rf .venv'
