" =============================================================================
" .vimrc 2.0 — CONFIGURAÇÃO LEVE
" =============================================================================
"
" Vim focado em:
"   - Linux
"   - Terminal
"   - Programação
"   - Git
"   - Tmux
"   - Markdown
"
" Plugins:
"   Gruvbox
"   Airline
"   Devicons
"   FZF
"   Fugitive
"   GitGutter
"   vim-surround
"   vim-tmux-navigator
"
" =============================================================================

" =============================================================================
" 1. CONFIGURAÇÃO INICIAL
" =============================================================================

set nocompatible

" Leader
let mapleader = ","
let maplocalleader = "\"

" UTF-8
set encoding=utf-8

" Cores modernas
if has('termguicolors')
set termguicolors
endif

set background=dark

" Sintaxe e plugins
filetype plugin indent on
syntax enable

" =============================================================================
" 2. DIRETÓRIOS DO VIM
" =============================================================================

if !isdirectory(expand('~/.vim/undodir'))
call mkdir(expand('~/.vim/undodir'), 'p')
endif

if !isdirectory(expand('~/.vim/swap'))
call mkdir(expand('~/.vim/swap'), 'p')
endif

if !isdirectory(expand('~/.vim/backup'))
call mkdir(expand('~/.vim/backup'), 'p')
endif

" =============================================================================
" 3. VIM-PLUG
" =============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```
autocmd VimEnter *
    \ PlugInstall --sync |
    \ source $MYVIMRC
```

endif

call plug#begin('~/.vim/plugged')

" -----------------------------------------------------------------------------
" Aparência
" -----------------------------------------------------------------------------

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons'

" -----------------------------------------------------------------------------
" Busca e navegação
" -----------------------------------------------------------------------------

Plug 'junegunn/fzf', {
\ 'do': { -> fzf#install() }
\ }

Plug 'junegunn/fzf.vim'

" -----------------------------------------------------------------------------
" Git
" -----------------------------------------------------------------------------

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" -----------------------------------------------------------------------------
" Edição
" -----------------------------------------------------------------------------

Plug 'tpope/vim-surround'

" -----------------------------------------------------------------------------
" Tmux
" -----------------------------------------------------------------------------

Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" =============================================================================
" 4. CONFIGURAÇÕES GERAIS
" =============================================================================

" Performance
set lazyredraw
set ttyfast
set updatetime=500

" Interface
set title
set ruler
set showcmd
set showmode

" Arquivos
set hidden
set autoread
set confirm

" Backspace
set backspace=indent,eol,start

" Janelas
set splitbelow
set splitright

" Linhas
set nowrap
set linebreak

" Sem sons
set noerrorbells
set visualbell

" Mouse
set mouse=a

" =============================================================================
" 5. ARQUIVOS / BACKUP / SWAP
" =============================================================================

" Swap
set swapfile
set directory^=~/.vim/swap//

" Backup
set backup
set backupdir=~/.vim/backup//

" Undo persistente
set undofile
set undodir=~/.vim/undodir//

set undolevels=1000
set undoreload=10000

" =============================================================================
" 6. NÚMEROS E CURSOR
" =============================================================================

set number
set relativenumber

set cursorline

set scrolloff=5
set sidescrolloff=5

" =============================================================================
" 7. INDENTAÇÃO PADRÃO
" =============================================================================

set autoindent
set smartindent

set expandtab

set tabstop=4
set softtabstop=4
set shiftwidth=4

set shiftround

" =============================================================================
" 8. BUSCA
" =============================================================================

set ignorecase
set smartcase

set incsearch
set hlsearch

" =============================================================================
" 9. COMPLETAMENTO NATIVO DO VIM
" =============================================================================

set completeopt=menuone,noinsert,noselect

set wildmenu
set wildmode=longest:full,full

set wildignorecase

set wildignore=*.o,*~
set wildignore+=*.pyc
set wildignore+=*.class
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=node_modules/*
set wildignore+=.git/*

" =============================================================================
" 10. CARACTERES INVISÍVEIS
" =============================================================================

set nolist

set listchars=tab:»\ ,trail:·,extends:»,precedes:«,nbsp:×

" =============================================================================
" 11. CLIPBOARD
" =============================================================================

set clipboard=unnamedplus

" =============================================================================
" 12. HISTÓRICO
" =============================================================================

set history=1000

" =============================================================================
" 13. TEMA — GRUVBOX
" =============================================================================

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1

colorscheme gruvbox

" =============================================================================
" 14. AIRLINE
" =============================================================================

let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1

let g:airline_theme = 'gruvbox'

" =============================================================================
" 15. FZF
" =============================================================================

let g:fzf_layout = {
\ 'window': {
\ 'width': 0.90,
\ 'height': 0.70
\ }
\ }

" Procurar arquivos
nnoremap <silent> <leader>ff :Files<CR>

" Procurar buffers
nnoremap <silent> <leader>fb :Buffers<CR>

" Histórico de arquivos
nnoremap <silent> <leader>fh :History<CR>

" Procurar texto usando ripgrep
nnoremap <silent> <leader>fg :Rg<CR>

" Arquivo atual
nnoremap <silent> <leader>fo :FZF<CR>

" =============================================================================
" 16. GITGUTTER
" =============================================================================

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▔'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'

" =============================================================================
" 17. FUGITIVE — GIT
" =============================================================================

" Status do Git
nnoremap <silent> <leader>gs :Git<CR>

" Commit
nnoremap <silent> <leader>gc :Git commit<CR>

" Push
nnoremap <silent> <leader>gp :Git push<CR>

" Pull
nnoremap <silent> <leader>gl :Git pull<CR>

" Diff
nnoremap <silent> <leader>gd :Gdiffsplit<CR>

" Blame
nnoremap <silent> <leader>gb :Git blame<CR>

" Log
nnoremap <silent> <leader>glog :Git log<CR>

" =============================================================================
" 18. TMUX
" =============================================================================
"
" Ctrl-h → esquerda
" Ctrl-j → baixo
" Ctrl-k → cima
" Ctrl-l → direita
"
" O plugin vim-tmux-navigator cuida desses atalhos.

" =============================================================================
" 19. BUFFERS
" =============================================================================

nnoremap <silent> <leader>bn :bnext<CR>

nnoremap <silent> <leader>bp :bprevious<CR>

nnoremap <silent> <leader>bd :bdelete<CR>

nnoremap <silent> <leader>bl :ls<CR>

" =============================================================================
" 20. JANELAS
" =============================================================================

" Redimensionar vertical
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>

" Redimensionar horizontal
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" =============================================================================
" 21. MOVIMENTO EM LINHAS QUEBRADAS
" =============================================================================

nnoremap j gj
nnoremap k gk

" =============================================================================
" 22. SALVAR / SAIR
" =============================================================================

nnoremap <leader>w :write<CR>

nnoremap <leader>q :quit<CR>

nnoremap <leader>wq :wq<CR>

" =============================================================================
" 23. LIMPAR BUSCA
" =============================================================================

nnoremap <silent> <leader>nh :nohlsearch<CR>

" =============================================================================
" 24. TERMINAL
" =============================================================================

" Terminal
nnoremap <silent> <leader>tt :terminal<CR>

" Terminal horizontal
nnoremap <silent> <leader>tv :botright split | terminal<CR>

" Terminal vertical
nnoremap <silent> <leader>ts :botright vsplit | terminal<CR>

" Sair do modo terminal
tnoremap <Esc> <C-><C-n>

" =============================================================================
" 25. FORMATAÇÃO JSON
" =============================================================================

command! FormatJSON %!python3 -m json.tool

" =============================================================================
" 26. LIMPAR ESPAÇOS NO FINAL DAS LINHAS
" =============================================================================

function! CleanExtraSpaces()
let save_cursor = getpos('.')
let old_query = getreg('/')

```
silent! %s/\s\+$//e

call setpos('.', save_cursor)
call setreg('/', old_query)
```

endfunction

" =============================================================================
" 27. CONFIGURAÇÕES POR LINGUAGEM
" =============================================================================

augroup programming_settings
autocmd!

```
" -------------------------------------------------------------------------
" Python
" -------------------------------------------------------------------------

autocmd FileType python
    \ setlocal shiftwidth=4 |
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal expandtab

autocmd FileType python
    \ setlocal textwidth=88


" -------------------------------------------------------------------------
" C / C++
" -------------------------------------------------------------------------

autocmd FileType c,cpp
    \ setlocal shiftwidth=4 |
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal expandtab

autocmd FileType c,cpp
    \ setlocal cindent


" -------------------------------------------------------------------------
" Go
" -------------------------------------------------------------------------

autocmd FileType go
    \ setlocal noexpandtab |
    \ setlocal tabstop=4 |
    \ setlocal shiftwidth=4


" -------------------------------------------------------------------------
" Rust
" -------------------------------------------------------------------------

autocmd FileType rust
    \ setlocal shiftwidth=4 |
    \ setlocal tabstop=4 |
    \ setlocal softtabstop=4 |
    \ setlocal expandtab


" -------------------------------------------------------------------------
" JavaScript / TypeScript
" -------------------------------------------------------------------------

autocmd FileType javascript,typescript
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal expandtab


" -------------------------------------------------------------------------
" HTML / CSS
" -------------------------------------------------------------------------

autocmd FileType html,css
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal expandtab


" -------------------------------------------------------------------------
" JSON
" -------------------------------------------------------------------------

autocmd FileType json
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal expandtab


" -------------------------------------------------------------------------
" YAML
" -------------------------------------------------------------------------

autocmd FileType yaml
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=2 |
    \ setlocal softtabstop=2 |
    \ setlocal expandtab


" -------------------------------------------------------------------------
" Markdown
" -------------------------------------------------------------------------

autocmd FileType markdown
    \ setlocal spell |
    \ setlocal spelllang=pt_br,en

autocmd FileType markdown
    \ setlocal wrap |
    \ setlocal linebreak |
    \ setlocal nolist


" -------------------------------------------------------------------------
" Git commit
" -------------------------------------------------------------------------

autocmd FileType gitcommit
    \ setlocal spell


" -------------------------------------------------------------------------
" Limpar espaços antes de salvar
" -------------------------------------------------------------------------

autocmd BufWritePre *
    \ call CleanExtraSpaces()


" -------------------------------------------------------------------------
" Atualizar arquivos modificados externamente
" -------------------------------------------------------------------------

autocmd FocusGained,BufEnter *
    \ checktime
```

augroup END

" =============================================================================
" 28. RESTAURAR POSIÇÃO DO CURSOR
" =============================================================================

augroup restore_cursor
autocmd!

```
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     execute "normal! g`\"" |
    \ endif
```

augroup END

" =============================================================================
" 29. ATALHOS DE EDIÇÃO
" =============================================================================

" Indentar bloco visual e permanecer selecionado
vnoremap < <gv
vnoremap > >gv

" Mover linhas para cima/baixo no modo visual
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" =============================================================================
" 30. EXECUTAR PROGRAMAS
" =============================================================================

" Python
augroup run_programs
autocmd!

```
autocmd FileType python
    \ nnoremap <buffer> <leader>r :write<CR>:!python3 %<CR>

autocmd FileType c
    \ nnoremap <buffer> <leader>r :write<CR>:!gcc % -o %:r && ./%:r<CR>

autocmd FileType cpp
    \ nnoremap <buffer> <leader>r :write<CR>:!g++ % -std=c++17 -Wall -Wextra -o %:r && ./%:r<CR>

autocmd FileType go
    \ nnoremap <buffer> <leader>r :write<CR>:!go run %<CR>

autocmd FileType rust
    \ nnoremap <buffer> <leader>r :write<CR>:!rustc % -o /tmp/vim_rust_program && /tmp/vim_rust_program<CR>

autocmd FileType javascript
    \ nnoremap <buffer> <leader>r :write<CR>:!node %<CR>

autocmd FileType typescript
    \ nnoremap <buffer> <leader>r :write<CR>:!npx ts-node %<CR>
```

augroup END

" =============================================================================
" 31. INFORMAÇÕES DO EDITOR
" =============================================================================

" Mostrar espaços e tabs quando solicitado
command! ShowWhitespace set list!

" Mostrar informações do Vim
command! VimInfo version

" =============================================================================
" 32. FINAL
" =============================================================================
"
" ATALHOS PRINCIPAIS
"
" ─────────────────────────────────────────────────────────────────────────────
" ARQUIVOS
"
" ,ff       → procurar arquivos
" ,fb       → procurar buffers
" ,fh       → histórico
" ,fg       → procurar texto
" ,fo       → FZF
"
" ─────────────────────────────────────────────────────────────────────────────
" GIT
"
" ,gs       → Git status
" ,gc       → Git commit
" ,gp       → Git push
" ,gl       → Git pull
" ,gd       → Git diff
" ,gb       → Git blame
" ,glog     → Git log
"
" ─────────────────────────────────────────────────────────────────────────────
" BUFFERS
"
" ,bn       → próximo buffer
" ,bp       → buffer anterior
" ,bd       → fechar buffer
" ,bl       → listar buffers
"
" ─────────────────────────────────────────────────────────────────────────────
" TERMINAL
"
" ,tt       → terminal
" ,tv       → terminal horizontal
" ,ts       → terminal vertical
"
" ─────────────────────────────────────────────────────────────────────────────
" EXECUTAR CÓDIGO
"
" ,r        → executar arquivo atual
"
" Python    → python3
" C        → gcc
" C++      → g++
" Go       → go run
" Rust     → rustc
" JS       → node
" TS       → ts-node
"
" ─────────────────────────────────────────────────────────────────────────────
" EDITOR
"
" ,w        → salvar
" ,q        → sair
" ,wq       → salvar e sair
" ,nh       → limpar busca
"
" FZF       → busca de arquivos
" Fugitive  → Git
" GitGutter → alterações no Git
" Surround  → edição de delimitadores
"
" ─────────────────────────────────────────────────────────────────────────────
" TMUX
"
" Ctrl-h    → esquerda
" Ctrl-j    → baixo
" Ctrl-k    → cima
" Ctrl-l    → direita
"
" =============================================================================
" FIM
" =============================================================================
