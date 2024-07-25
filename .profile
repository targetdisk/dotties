for af in "$HOME/.aliases"/*; do
    . "$af"
done

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

if [ -d "$HOME/.profile.d" ]; then
    for pd in "$HOME/.profile.d"/*; do
        . "$pd"
    done
fi

command -v uname >/dev/null &&
  case $(uname) in
    FreeBSD)
      . "$HOME/.profile.freebsd"
      ;;
    Linux)
      . "$HOME/.profile.linux"
      ;;
  esac \
;
