for af in "$HOME/.aliases"/*; do
    . "$af"
done

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
  esac \
;
