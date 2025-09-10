perl_env() { eval $(perl -I $HOME/perl5/lib/perl5/ -Mlocal::lib) ; }

perl_env \
  || (
    command -v cpanm \
      && cpanm --local-lib=$HOME/perl5 local::lib \
      && perl_env \
    )
