" Enable spell checking for markdown files, Git descriptions/commit
" messages, plain text files (.txt), and reStructuredText.
"au BufRead *.c         setlocal spell
"setlocal spell spelllang=en_us
au BufRead,BufNewFile *.h         setlocal spell
au BufRead,BufNewFile *.md        setlocal spell
au BufRead,BufNewFile *.MD        setlocal spell
au BufRead,BufNewFile *.txt       setlocal spell
au BufRead,BufNewFile *.tex       setlocal spell
au BufRead,BufNewFile *.rst       setlocal spell
au BufRead,BufNewFile *.RST       setlocal spell
au BufRead,BufNewFile description setlocal spell
au BufRead,BufNewFile *MSG        setlocal spell
au BufRead,BufNewFile COMMIT*     setlocal spell
au BufRead,BufNewFile *.markdown  setlocal spell

function! MacPorty()
  set fileencoding=utf-8
  " set ft=portfile
  set filetype=tcl
  set shiftwidth=4
  set tabstop=4
  set softtabstop=4
endfunction

au BufRead,BufNewFile *Portfile    call MacPorty()

" Vundle reqs
set nocompatible
filetype off

" Enable Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle manages Vundle
Plugin 'VundleVim/Vundle.vim'

" Rainbow Parenthesis!
Plugin 'kien/rainbow_parentheses.vim'

" System-wide ctags
Plugin 'ntnn/vim-ctagser'

" Rust
Plugin 'rust-lang/rust.vim'

" Vim LSP/Async auto-complete
Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'

" My Librecode helpers
Plugin 'targetdisk/minitator'
au BufRead,BufNewFile *.annotated.head.json call minitator#macros()

call vundle#end()

"""""""""""""""""""""""""""""""
"  Async Auto-complete Stuff  "
"""""""""""""""""""""""""""""""
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
noremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

""""""""""""""""""""""""""""""""""""""""""""""""
"                  LSP Stuff                   "
""""""""""""""""""""""""""""""""""""""""""""""""
" Golang
if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-remote=auto']},
        \ 'allowlist': ['go', 'gomod', 'gohtmltmpl', 'gotexttmpl'],
        \ })

    autocmd BufWritePre *.go
        \ call execute('LspDocumentFormatSync') |
        \ call execute('LspCodeActionSync source.organizeImports')
endif

" Haskell
if executable('haskell-language-server-wrapper')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'haskell-language-server-wrapper',
        \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'],
        \     ))},
        \ 'whitelist': ['haskell', 'lhaskell'],
        \ })
endif

" Python
if executable('pylsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" Perl
if executable('pls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pls',
        \ 'cmd': {server_info->['pls']},
        \ 'allowlist': ['perl'],
        \ })
endif

" Bash
if executable('bash-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'bash-language-server',
         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
        \ 'allowlist': ['sh', 'bash'],
        \ })
endif

" Vimscript
if executable('vimscript-language-server')
  augroup LspVim
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'vimscript-language-server',
        \ 'cmd': {server_info->['vimscript-language-server']},
        \ 'allowlist': ['vim'],
        \ 'initialization_options': {
        \   'vimruntime': $VIMRUNTIME,
        \   'runtimepath': &rtp,
        \ }})
  augroup END
endif

" C/C++/Objective-C/Objective-C++
if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
elseif executable('ccls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ccls',
        \ 'cmd': {server_info->['ccls']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
       \ 'initialization_options': {},
       \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
       \ })
endif

" Rust
if executable('rust-analyzer')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rust-analyzer',
         \ 'cmd': {server_info->['rust-analyzer']},
        \ 'allowlist': ['rust'],
        \ })
endif

" TypeScript and ECMAScript
if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
    au User lsp_setup call lsp#register_server({
        \ 'name': 'javascript support using typescript-language-server',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
        \ })
endif

" Java! (kill me)
if executable('jdtls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'Eclipse JDT Language Server',
        \ 'cmd': {server_info->['jdtls', '-data', getcwd()]},
        \ 'allowlist': ['java']
        \ })
endif

" LSP config
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    "nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    "nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled on languages with a registered server.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""

" Trailing whitespace and tab hilighting
set list
set listchars=trail:â–“,tab:\:.

""""""""""""""""
" LaTeX macros "
""""""""""""""""
function! TexMacros()
    let @c = 'o\begin{€kb{multicols}{2}\end{multicols}k'
    let @d = 'o\begin{description}\end{description}kkj'
    let @e = 'o\gbe€kb€kb€kbbegin €kb{enumerate}\end{enumerate}k'
    let @f = 'a\frac{'
    let @i = 'o\item €kb'
    let @m = 'i\documentclass{book}\usepackage[sortcites=true,sorting=nyt,backend=biber]{biblatex}\usepackage[normalem]{ulem}\usepackage[many]{tcolorbox}\usepackage{tikz}\usetikzlibrary{decorations.markings}\usepackage{pgfplots}\pgfplotsset{compat=1.18}%\pgfplotsset{compat=1.11}\usepackage{multicol}\usepackage{textcomp}\usepackage{amsmath}\usepackage{enumitem}\usepackage{dingbat}\usepackage{caption}\usepackage{framed}\usepackage{graphicx}\usepackage{setspace}%\usepackage{xintexpr}\usepackage{multirow}\usepackage{dcolumn}\usepackage{xcolor,cancel}\newcommand\hcancel[2][black]{\setbox0=\hbox{$#2$}%\rlap{\raisebox{.45\ht0}{\textcolor{#1}{\rule{\wd0}{1pt}}}}#2}%\usepackage[table,cancel]{xcolor}%\definecolor{lightgray}{gray}{0.9}\title{Math 105 Homework}\author{targetdisk}\addbibresource{105.bib}\begin{document}\newcolumntype{2}{D{.}{}{2.0}}\maketitle\tableofcontents\printbibliography €kb€kb€kb€kb€kb€kb€kb€kb€kb€kbliography\end{document}€ýakkkkkkkkkkkkkkkkjjjjjjjjkjjjjkjjj^'
    let @p = 'o\begin{itemize}\end{itemize}k'
    let @s = 'a\sqrt{'
    let @y = 'o[€kb\[\renewcommand\arraystretch{1.5}\setlength\doubleruleseo€kbp{0pt}\begin{array}{rrrrrr}\multicolumn{1}{r|}{6} & €kb€kb€kb€kb€kbdiv} &   €kb€kb€kb    €kb€kb€kb€kb    &    &    &    &    &€kb€kb€kb€kb€kb    \\\cline{2-6}       €kb&    &    &    &    &    \\\l€kbcline{2-6}&    &    &    &    &\end{array}\]kkkkwwwwwbbhhllllllhlhlhr[r{lllr}jkhhhhhhhhlhl'
endfunction
augroup latex
    autocmd!
    autocmd BufNewFile,BufRead *.tex   call TexMacros()
augroup END

" For new LaTeX files
function! TexTabs()
    set expandtab tabstop=4 shiftwidth=4
endfunction

""""""""""""""""

" For two-space indenting
function! TwoTabs()
    set expandtab tabstop=2 shiftwidth=2
endfunction

syntax on
set ruler
set number
"set autoindent
set cursorline

" I use dark mode on all platforms except for Macintosh.
if has('macunix') || has('mac')
  set background=light
else
  set background=dark
endif

" For login terminals on Macs
set shell=bash\ -l

" Filetype auto-indent
if has("autocmd")
  filetype on
  filetype plugin indent on
endif

function! Terminal()
  execute 'ter'
endfunction
function! VertTerminal()
  execute 'vert ter'
endfunction

" Super special mappings
map <F1> :call Terminal()<cr>
map <S-F1> :call VertTerminal()<cr>
map <F2> :!git grep -n '<cword>' $(git rev-parse --show-toplevel)<cr>
map <F3> :!git blame %<cr>
map <F5> :w!<cr>:!xelatex %<cr>
map <F9> :w!<cr>:!md-previewer %<cr>
map <F11> :set background=dark<cr>
map <S-F11> :set background=light<cr>
map <F12> :mksession!<cr>

" Rainbow Parenthesis settings
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Read my lips: NO MOUSE
autocmd BufEnter * set mouse=
