# Python
alias mk-venv='python -m venv .venv'
alias do-venv='. .venv/bin/activate'
alias rm-venv='rm -rf .venv'

[ -n "$(command -v pdb)" ] || alias pdb='python -m pdb'
[ -n "$(command -v pip)" ] || alias pip='python -m pip'
