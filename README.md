# vimrc
Minhas Configurações do Vim
.vim/vimrc
Ainda esta em desenvolvimeto

###$🛠️ Correção Rápida (opcional):
- 1. Se quiser usar source no terminal sem erros, transforme seu vimrc em um script compatível com shell:
``` bash
#!/bin/bash
# Este é um WRAPPER para carregar o vimrc no Vim
vim -u ~/.config/vimrc/vimrc "$@"
```

  - Salve como vimrc-loader.sh e execute com:

``` bash
chmod +x vimrc-loader.sh
./vimrc-loader.sh
```

### 🔧 Vimrc Corrigido (só ajustes de compatibilidade):
``` bash
" ======================================================================
" CONFIGURAÇÕES BÁSICAS
" ======================================================================

" Verifica suporte a cores verdadeiras
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif

" Ativa recursos essenciais
filetype plugin indent on
syntax on
set title
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden
set splitbelow
set splitright
set fillchars=vert:│,fold:-,eob:~,lastline:@
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Formatação de texto
set nowrap
set linebreak
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲

" Números e cursor
set number
set relativenumber
set scrolloff=2
set cursorline
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Indentação
set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Busca
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

" Autocompletar
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
set spelllang=pt_br,en

" Interface
set wildmenu
set wildmode=longest,full
set wildoptions=pum
colorscheme industry
set noshowmode
set laststatus=2

" ======================================================================
" BARRA DE STATUS PERSONALIZADA
" ======================================================================
function! LoadStatusLine()
    let g:left_sep = '|'
    let g:right_sep = '|'

    let g:currentmode = {
        \ 'n': 'Normal',
        \ 'v': 'Visual',
        \ 'i': 'Insert',
        \ 'R': 'Replace',
        \ 'c': 'Command',
        \ 't': 'Terminal'
        \}

    set statusline=\ %{toupper(g:currentmode[mode()])}
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
    set statusline+=\ %{right_sep}
    set statusline+=\ %{strftime('%H:%M')}
endfunction

call LoadStatusLine()

" Destaques visuais
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=#202130
hi Comment cterm=italic gui=italic
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0
hi TabLine guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill guifg=#9192a0 guibg=#303140 gui=none
hi Visual guifg=NONE guibg=#303140
``` 
