" -----------------------------------------------------------------------------
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif
" -----------------------------------------------------------------------------
"  :nohlsearch
"  limpa qualquer marcaçao de busca no arquivo
filetype plugin indent on
"  Ativa detccção automatica do tipo de arquivo,
"  plugins e indentação filetype plugin indent on
"  Ativa a sintaxe realçada
syntax on
"  Ativa a sintaxe realçada
set title
"  Define o titulo da janela para o nome do arquivo 
"set encoding=utf-8
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
"  Habilita a exibição dos numeros das linhas no lado esquerdo da janela,
"  permitindo que voce veja o numero de cada linha no arquivo.
set relativenumber
"  Quando Ativado, exibe numeros relativos em relação a linha atual.
set scrolloff=2
"  Defeine uma margem de rolagem.
set cursorline
"  Destaca a linha atual do curso esta localizado.
" -----------------------------------------------------------------------------
let &t_SI="\e[6 q"
"  Define a sequencia de escape que o terminal usara para iniciar o modo de
"  curso intermitente.
let &t_EI="\e[2 q"
"  Define a sequencia de escape que o terminal usara pra encerrar o modo de
"  curso intermitente.
" -----------------------------------------------------------------------------
set autoindent
"  Quando ativado, o Vim ira automaticamente identar o novo texto com base na
"  linha anterior.
set smartindent
"  Esta opção inteligente de indentação faz com que o Vim ajuste
"  automaticamnte a indentação com base na estrutura do codigo.
" -----------------------------------------------------------------------------
set expandtab
"  Essa configuração faz com que o vim insira espços em vez de tsbulaçoes
"  quando a tecla Tab e pressionada.  
set tabstop=4
" Define o numero de colunas que uma tabulaçao apresenta no editor.
set softtabstop=4
"  Esta configuraçao define o comportamento da tecla Tab e da Backspace quando
"  a opçao expandtab esta ativada.
set shiftwidth=4
"  Define quantos espaços o Vim usara ao realizar operaçoes como recuo
"  automatico e formataçao de codigo.
" -----------------------------------------------------------------------------
set ignorecase
"  Ao ativar esta opção, as pesquisas no vim serão realizadas sem diferenciar
"  mauisculas de minusculas, ou seja a pesquisa sera realizada se forma
"  case-insensitive.
set smartcase
"  Esta configuração ajusta o comportamento da pesquisa para ser
"  case-sensitive somente quando a espressao de pesquisa contem letras
"  maisculas.
set incsearch
"  Com esta opçao ativada, o vim ira atualizar a correspondencia da pesquisa
"  enquanto voce digita, realçando a primeira ocorrencia encontrada a medida
"  que voce digita a expressao de pesquisa.
set hls
"  A breviação de hlsearch, essa configuraçao ativa o realce das
"  correspondecias de pesquisa (search highight).
let @/ = ""
"  Isso redefine o registro / (usado para armazenar a ultimas busca) como uma
"  string vazia,limpando a pesquisa anterior. 
" -----------------------------------------------------------------------------
set complete+=kspell
"  Esta Configuraçao adiciona o metodo de completar palavras usando o
"  verificador ortografico do vim (kspell).
set completeopt=menuone,longest
"  Aqui, estamos definindo as opções para o comando de conclusão (completação) 
"  no Vim. Com menuone, o menu de conclusão será exibido automaticamente quando 
"  houver apenas uma opção disponível. A opção longest garante que o Vim insira
"  a sequência de caracteres mais longa possível ao pressionar Tab para concluir 
"  palavras.
set shortmess+=c
"  Esta configuraçao adiciona a letra "c" s lista de mesagens curtas, que
"  geralmente siginifica que algumas mesagens informadas e de confirmação
"  serão suprimidas ou exibidas de forma mais compacta.
set spelllang=pt_br,en
"  Define os idiomas a serem usados para a verificação ortografica.
"set nospell
"  

" Insert completion...

" -- Select with arrows up and down --
"inoremap <expr> <up> pumvisible() ? '<c-p>' : '<up>'
"inoremap <expr> <down> pumvisible() ? '<c-n>' : '<down>'

" -- Accept with right arrow or enter --
"inoremap <expr> <right> pumvisible() ? '<c-y>' : '<right>'
"inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'

" -- Cancel completion with left arrow --
"inoremap <expr> <left> pumvisible() ? '<c-e>' : '<left>'

"function! Hashbangs()
    "let hb = ['#!/bin/bash', '#!/usr/bin/env bash', '#!/bin/sh', '#!/usr/bin/awk -f']
    "call complete(col('.'), hb)
    "return ''
"endfunction

"imap <c-a>s <c-r>=Hashbangs()<cr>
" -----------------------------------------------------------------------------
set wildmenu
"  Mostra um menu pop-up para selecionar opçoes de conclusão 
"  de comandos ou nomes de arquivos .
set wildmode=longest,full
"  Determina o comportamento do preenchimento automatico,
"  priorizando o texto mais longo em comum entre as 
"  opções e inserindo a opçao completa.
set wildoptions=pum
"  Define as opções para o modo selvagem, ultilizando um 
"  menu pop-up para exibir as opções de preenchimento automatico.
" -----------------------------------------------------------------------------
" https://github.com/sainnhe/edge.git 
" set background=dark
 "colorscheme edge
" -----------------------------------------------------------------------------
colorscheme habamax
" -----------------------------------------------------------------------------
set noshowmode
"  Ao definir isso, voce esta desativando a exibição do modo de ediçao
"  atual(como INSETE, VISUAL,etc.) na linha de status do Vim.
set laststatus=2
"  Com esta configuraçao, voce esta definindo o status da linha para sempre se
"  exibido.

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
    "  configura em lestras maiusculas na linha de status 
    " set statusline=\ %{toupper(mode())}

    set statusline+=\ %{left_sep}
    "  Separador visual a esquerda na linha de status.
    "
    set statusline+=\ %n
    " Exiber o numero da linha atual do arquivo na linha de status
    set statusline+=\ %{left_sep}
    "  Separador visual a esquerda na linha de status.
    set statusline+=\ %f%m\ %y
    "  Nome do arquivo (%f), indicadores de modificaçao(%m), indicadores de
    "  arquivos ocutos(%y).
    set statusline+=\ %{left_sep}
    "  Separador visual a esquerda na linha de status.
    set statusline+=\ %{&ff}\ %{&fenc!=''?&fenc:&enc}
    "  Exibiçao do formato de arquivos, e codificaçao do arquivo
    set statusline+=\ %{left_sep}
    "  Separador visual a esquerda na linha de status.
    set statusline+=\ %=
    "  Este comando posiciona os proximos elementos da linha de status a
    "  direita, permitindo uma formatação.
    set statusline+=\ %{right_sep}
    "  Separador visual a direita na linha de status.
    set statusline+=\ %l/%L,%v
    "  Exiber o numero de linhas atual e o numero total de linhas no arquivos,
    "  juntamente com a porcentagem de avanço vertical no arquivo.
    set statusline+=\ %{right_sep}
    "  Separador visual a esquerda na linha de status.
    set statusline+=\ %P\ 
    "  Exiber a porcentagem de avanço horizontal no aquivo, permitindo ter uma
    "  ideia do progresso ao longo do documento.
    set statusline+=\ %{right_sep}
    "  Separador visual a esquerda na linha de status.
    set statusline+=\ %{strftime('%H:%M')}
    "Adiciona a hora atual a barra de status 

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


