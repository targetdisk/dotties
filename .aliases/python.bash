# Python
alias mk-venv='python -m venv .venv'
alias do-venv='. .venv/bin/activate'
alias rm-venv='rm -rf .venv'

command -v pdb > /dev/null || alias pdb='python -m pdb'
command -v pip > /dev/null || alias pip='python -m pip'
