if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
elif [ -d "$HOME/.cargo/bin" ]; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

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

export EDITOR=`which vim`
