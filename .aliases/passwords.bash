: '
  *  A file with some password-creation/management "aliases"
  '

_tmkpasswd() {
  [ -n "$1" ] && local passlen=$1 || local passlen=20
  echo $(cat /dev/"$2"random | strings | head -c 512 | grep -oE '[a-zA-Z0-9#@$%!]')\
    | sed 's/\s//g' | head -c $passlen
}

tmkpasswd() {
  [ $(command -v wl-copy) ] && _tmkpasswd $@ | wl-copy || \
    ( _tmkpasswd $@ && echo )
}
