" -----------------------------------------------------------------------------
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif
" -----------------------------------------------------------------------------
filetype plugin indent on
"  Ativa detccção automatica do tipo de arquivo,
"  plugins e indentação filetype plugin indent on
"  Ativa a sintaxe realçada
syntax on
"  Ativa a sintaxe realçada
set title
"  Define o titulo da janela para o nome do arquivo 
set encoding=utf-8
"  Define a codifiçaão para UTF-8
set backspace=indent,eol,start
"  Permite retroceder a apagar tudo
" (indetação, fianl de linha, inicio de linha)
set noerrorbells
"  Desativa os sons de erro
set confirm
"  Requer confirmação de abandonar um arquivo 
"  não salvo ou editar um arquivo somente leitura

set hidden
"  Permite que os buffers ocutls sejam mantidos em segundo plano
set splitbelow
"  Divide a janela abaixo da atual ao abrir uma nova janela 
set splitright
"  Divide a janela a direita da atual ao abrir uma nova janela 
set fillchars=vert:│,fold:-,eob:~,lastline:@
"  Define os caracteres usados para preencher espaços em branco
"  nas janelas verticais e horizontais, e no final das linhas 
" -----------------------------------------------------------------------------
set path=.,**
"  Define o caminho de busca para incluir o diretorio atual e todos 
"  os subdiretorio
"
set noswapfile
"  Desativa a criaçao de arquivos de troca 
"
set nobackup
"  Desativa a criação de arquivos de backup
"
set undodir=~/.vim/undodir
"  Define o diretorio onde os aquivos de desfazer (undo) serao armazenados 
set undofile
"  Ativa a persistencia dos arquivos de desfazer (undo) entre sessões
"
" -----------------------------------------------------------------------------
set nowrap
"  Desativa a quebra de linha automatica
set linebreak
"  Ativa a quebra de linha visual, sem modicar o conteudo do arquivo 
set nolist
"  Desativa a exibição de caracteres especiais (espaço, tabulações, etc.)
set listchars=tab:›-,space:·,trail:◀,eol:↲
"  Define os caracteres usados para exibir espaços em branco,
"  tabulações e final de linha
" -----------------------------------------------------------------------------
set number 
set relativenumber
set scrolloff=2
set cursorline
" -----------------------------------------------------------------------------
let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
" -----------------------------------------------------------------------------
set autoindent
set smartindent
" -----------------------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
" -----------------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""
" -----------------------------------------------------------------------------
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c

set spelllang=pt_br,en
set nospell

" Insert completion...

" -- Select with arrows up and down --
inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'

" -- Accept with right arrow or enter --
inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'

" -- Cancel completion with left arrow --
inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

function! Hashbangs()
    let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    call complete(col('.'), hb)
    return ''
endfunction

imap <c-a>s <c-r>=Hashbangs()<cr>
" -----------------------------------------------------------------------------
set wildmenu
set wildmode=longest,full
set wildoptions=pum
" -----------------------------------------------------------------------------
" https://github.com/sainnhe/edge.git 
" set background=dark
 "colorscheme edge
" -----------------------------------------------------------------------------
colorscheme habamax
" -----------------------------------------------------------------------------
set noshowmode
set laststatus=2

hi statusline   cterm=NONE ctermfg=0 ctermbg=7   guibg=#C1C2D0 guifg=#000000
hi statuslinenc cterm=NONE ctermfg=0 ctermbg=240 guibg=#616270 guifg=#000000

augroup ModeEvents
    autocmd!
    au InsertEnter * hi statusline cterm=NONE ctermfg=0 ctermbg=10 guibg=#7BC86F
    au InsertLeave * hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
    au ModeChanged *:[vV\x16]* hi statusline cterm=NONE ctermfg=0 ctermbg=13 guibg=#C990DC
    au Modechanged [vV\x16]*:* hi statusline cterm=NONE ctermfg=0 ctermbg=7 guibg=#C1C2D0
augroup end

function! LoadStatusLine()

    let g:left_sep='|'
    let g:right_sep='|'

    let g:currentmode={
        \ 'n'  : 'Normal',
        \ 'no' : 'Normal-Operator Pending',
        \ 'v'  : 'Visual',
        \ 'V'  : 'V-Line',
        \ '' : 'V-Block',
        \ 's'  : 'Select',
        \ 'S'  : 'S-Line',
        \ '' : 'S-Block',
        \ 'i'  : 'Insert',
        \ 'R'  : 'Replace',
        \ 'Rv' : 'V-Replace',
        \ 'c'  : 'Command',
        \ 'cv' : 'Vim Ex',
        \ 'ce' : 'Ex',
        \ 'r'  : 'Prompt',
        \ 'rm' : 'More',
        \ 'r?' : 'Confirm',
        \ '!'  : 'Shell',
        \ 't'  : 'Terminal'
        \}

    set statusline=\ %{toupper(g:currentmode[mode()])}
    " set statusline=\ %{toupper(mode())}
    set statusline+=\ %{left_sep}
    set statusline+=\ %n
    set statusline+=\ %{left_sep}
    set statusline+=\ %f%m\ %y
    set statusline+=\ %{left_sep}
    set statusline+=\ %{&ff}\ %{&fenc!=''?&fenc:&enc}
    set statusline+=\ %{left_sep}
    set statusline+=\ %=
    set statusline+=\ %{right_sep}
    set statusline+=\ %l/%L,%v
    set statusline+=\ %{right_sep}
    set statusline+=\ %P\ 
    "Adiciona a hora atual a barra de status 
    set statusline+=\ %{strftime('%H:%M')}

endfunction

call LoadStatusLine()

" -----------------------------------------------------------------------------
hi Normal guibg=NONE ctermbg=NONE

hi CursorLine guibg=#202130

hi Comment cterm=italic gui=italic

hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0

hi TabLine      guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel   guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill  guifg=#9192a0 guibg=#303140 gui=none

hi Visual guifg=NONE guibg=#303140


