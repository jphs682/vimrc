" =============================================================================
" .vimrc 2.0 — CONFIGURAÇÃO COMPLETA
" =============================================================================
"
" Foco:
"   - Desenvolvimento
"   - Linux / Terminal
"   - Git
"   - Python, C/C++, Go, Rust, JS/TS, HTML/CSS
"   - Markdown
"   - Tmux
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

" Interface moderna
if has('termguicolors')
set termguicolors
endif

set background=dark

" Habilitar recursos de arquivo
filetype plugin indent on
syntax enable

" =============================================================================
" 2. DIRETÓRIOS DO VIM
" =============================================================================

" Criar diretórios necessários automaticamente
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
" 3. GERENCIAMENTO DE PLUGINS — VIM-PLUG
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
" Interface
" -----------------------------------------------------------------------------

Plug 'morhetz/gruvbox'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons'

" -----------------------------------------------------------------------------
" Navegação
" -----------------------------------------------------------------------------

Plug 'junegunn/fzf', {
\ 'do': { -> fzf#install() }
\ }

Plug 'junegunn/fzf.vim'

Plug 'preservim/nerdtree'

Plug 'mhinz/vim-startify'

" -----------------------------------------------------------------------------
" Desenvolvimento
" -----------------------------------------------------------------------------

Plug 'neoclide/coc.nvim', {
\ 'branch': 'release'
\ }

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

" -----------------------------------------------------------------------------
" Edição
" -----------------------------------------------------------------------------

Plug 'preservim/nerdcommenter'

Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'

" -----------------------------------------------------------------------------
" Histórico
" -----------------------------------------------------------------------------

Plug 'mbbill/undotree'

" -----------------------------------------------------------------------------
" Terminal / Tmux
" -----------------------------------------------------------------------------

Plug 'christoomey/vim-tmux-navigator'

" -----------------------------------------------------------------------------
" Linguagens
" -----------------------------------------------------------------------------

Plug 'sheerun/vim-polyglot'

call plug#end()

" =============================================================================
" 4. CONFIGURAÇÕES GERAIS
" =============================================================================

" Performance
set lazyredraw
set ttyfast
set updatetime=300

" Interface
set title
set showcmd
set showmode
set ruler

" Arquivos
set hidden
set autoread
set confirm

" Backspace
set backspace=indent,eol,start

" Divisão de janelas
set splitbelow
set splitright

" Não quebrar linhas automaticamente
set nowrap

" Quebra visual inteligente
set linebreak

" Preencher espaços vazios
set fillchars=vert:│,fold:-,eob:~

" Caminho de busca
set path=.,**

" Sem mensagens sonoras
set noerrorbells
set visualbell

" Mouse
set mouse=a

" =============================================================================
" 5. SWAP / BACKUP / UNDO
" =============================================================================

" Swapfile
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

" Cursor em formato de bloco no modo normal
if &term =~ "xterm"
let &t_EI = "<Esc>[2 q"
let &t_SI = "<Esc>[6 q"
endif

" =============================================================================
" 7. INDENTAÇÃO
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
" 9. AUTOCOMPLETAR / MENU
" =============================================================================

set completeopt=menuone,noinsert,noselect

set shortmess+=c

set wildmenu
set wildmode=longest:full,full

set wildignorecase

set wildignore=*.o,*~,*.pyc
set wildignore+=*.class
set wildignore+=*.so
set wildignore+=*.swp
set wildignore+=node_modules/*
set wildignore+=.git/*

" =============================================================================
" 10. LISTAS / CARACTERES INVISÍVEIS
" =============================================================================

set nolist

set listchars=
set listchars+=tab:»\
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:×

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
" 15. NERDTree
" =============================================================================

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

let g:NERDTreeIgnore = [
\ '.git$',
\ '.swp$',
\ '.pyc$',
\ '**pycache**'
\ ]

" Abrir / fechar árvore
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" Encontrar arquivo atual
nnoremap <silent> <leader>nf :NERDTreeFind<CR>

" =============================================================================
" 16. FZF
" =============================================================================

let g:fzf_layout = {
\ 'window': {
\ 'width': 0.90,
\ 'height': 0.70
\ }
\ }

" Arquivos
nnoremap <silent> <leader>ff :Files<CR>

" Buffers
nnoremap <silent> <leader>fb :Buffers<CR>

" Histórico
nnoremap <silent> <leader>fh :History<CR>

" Procurar texto
nnoremap <silent> <leader>fg :Rg<CR>

" =============================================================================
" 17. COC — AUTOCOMPLETAR
" =============================================================================

let g:coc_global_extensions = [
\ 'coc-json',
\ 'coc-html',
\ 'coc-css',
\ 'coc-pyright',
\ 'coc-rust-analyzer',
\ 'coc-clangd',
\ 'coc-go',
\ 'coc-tsserver',
\ 'coc-snippets',
\ 'coc-prettier',
\ 'coc-eslint'
\ ]

" -----------------------------------------------------------------------------
" Navegação
" -----------------------------------------------------------------------------

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" -----------------------------------------------------------------------------
" Renomear
" -----------------------------------------------------------------------------

nnoremap <leader>rn <Plug>(coc-rename)

" -----------------------------------------------------------------------------
" Formatação
" -----------------------------------------------------------------------------

nnoremap <silent> <leader>f :call CocActionAsync('format')<CR>

xnoremap <silent> <leader>f :<C-u>call CocActionAsync('formatSelected')<CR>

" -----------------------------------------------------------------------------
" Mostrar documentação
" -----------------------------------------------------------------------------

nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" -----------------------------------------------------------------------------
" Diagnósticos
" -----------------------------------------------------------------------------

nnoremap <silent> <leader>dn :CocDiagnosticNext<CR>
nnoremap <silent> <leader>dp :CocDiagnosticPrevious<CR>
nnoremap <silent> <leader>dl :CocList diagnostics<CR>

" =============================================================================
" 18. GITGUTTER
" =============================================================================

let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▔'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'

" =============================================================================
" 19. GIT — FUGITIVE
" =============================================================================

nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>

" =============================================================================
" 20. UNDOTREE
" =============================================================================

nnoremap <F5> :UndotreeToggle<CR>

let g:undotree_SetFocusWhenToggle = 1

" =============================================================================
" 21. NERDCOMMENTER
" =============================================================================

" Usa <leader>c para comentar/descomentar
let g:NERDCreateDefaultMappings = 1

let g:NERDSpaceDelims = 1

" =============================================================================
" 22. TERMINAL
" =============================================================================

" Terminal simples
nnoremap <silent> <leader>tt :terminal<CR>

" Terminal horizontal
nnoremap <silent> <leader>tv :botright split | terminal<CR>

" Terminal vertical
nnoremap <silent> <leader>ts :botright vsplit | terminal<CR>

" Sair do modo terminal
tnoremap <Esc> <C-><C-n>

" =============================================================================
" 23. TMUX / NAVEGAÇÃO ENTRE JANELAS
" =============================================================================

" O plugin vim-tmux-navigator utiliza:
"
" Ctrl-h → esquerda
" Ctrl-j → baixo
" Ctrl-k → cima
" Ctrl-l → direita
"
" Por isso não usamos Ctrl-h/Ctrl-l para trocar buffers.

" =============================================================================
" 24. BUFFERS
" =============================================================================

nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" Listar buffers
nnoremap <silent> <leader>bl :ls<CR>

" =============================================================================
" 25. JANELAS
" =============================================================================

" Redimensionar horizontalmente
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>

" Redimensionar verticalmente
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" =============================================================================
" 26. MOVIMENTO EM LINHAS QUEBRADAS
" =============================================================================

nnoremap j gj
nnoremap k gk

" =============================================================================
" 27. SALVAR / SAIR
" =============================================================================

nnoremap <leader>w :write<CR>

nnoremap <leader>q :quit<CR>

nnoremap <leader>wq :wq<CR>

" =============================================================================
" 28. LIMPAR HIGHLIGHT DA BUSCA
" =============================================================================

nnoremap <silent> <leader>nh :nohlsearch<CR>

" =============================================================================
" 29. FORMATAÇÃO JSON
" =============================================================================

command! FormatJSON %!python3 -m json.tool

" =============================================================================
" 30. LIMPAR ESPAÇOS NO FINAL DAS LINHAS
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
" 31. AUTOCOMMANDS
" =============================================================================

augroup user_settings
autocmd!

```
" Limpar espaços antes de salvar
autocmd BufWritePre * call CleanExtraSpaces()

" Recarregar arquivos alterados externamente
autocmd FocusGained,BufEnter * checktime

" Python
autocmd FileType python
    \ setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

autocmd FileType python
    \ nnoremap <buffer> <leader>r :write<CR>:!python3 %<CR>

" JavaScript / TypeScript
autocmd FileType javascript,typescript
    \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" HTML / CSS
autocmd FileType html,css
    \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" JSON
autocmd FileType json
    \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" YAML
autocmd FileType yaml
    \ setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Markdown
autocmd FileType markdown
    \ setlocal spell spelllang=pt_br,en

autocmd FileType markdown
    \ setlocal wrap linebreak nolist

" Git commit
autocmd FileType gitcommit
    \ setlocal spell
```

augroup END

" =============================================================================
" 32. STARTIFY
" =============================================================================

let g:startify_change_to_dir = 1

let g:startify_lists = [
\ { 'type': 'files',     'header': ['   Arquivos recentes'] },
\ { 'type': 'dir',       'header': ['   Diretório atual'] },
\ { 'type': 'sessions',  'header': ['   Sessões'] },
\ { 'type': 'commands',  'header': ['   Comandos'] },
\ ]

" =============================================================================
" 33. CONFIGURAÇÃO DO COLETA / STATUS
" =============================================================================

set statusline=%<%f\ %h%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)
set statusline+=\ %P

" =============================================================================
" 34. SEGURANÇA E CONFIRMAÇÕES
" =============================================================================

" Permite editar arquivos que foram modificados externamente
set autoread

" Perguntar antes de sair com alterações
set confirm

" =============================================================================
" 35. FINAL
" =============================================================================

" Mantém o cursor na última posição conhecida do arquivo
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
" FIM DO .vimrc 2.0
" =============================================================================
"
" PRINCIPAIS ATALHOS
"
" ,e       → Abrir/fechar NERDTree
" ,nf      → Encontrar arquivo no NERDTree
"
" ,ff      → Procurar arquivos
" ,fb      → Procurar buffers
" ,fh      → Histórico
" ,fg      → Procurar texto
"
" ,bn      → Próximo buffer
" ,bp      → Buffer anterior
" ,bd      → Fechar buffer
"
" ,gs      → Git
" ,gc      → Git commit
" ,gp      → Git push
" ,gl      → Git pull
" ,gd      → Git diff
" ,gb      → Git blame
"
" ,rn      → Renomear símbolo (CoC)
" ,f       → Formatar código
" ,dn      → Próximo diagnóstico
" ,dp      → Diagnóstico anterior
" ,dl      → Lista de diagnósticos
"
" F5       → Undotree
"
" ,tt      → Terminal
" ,tv      → Terminal horizontal
" ,ts      → Terminal vertical
"
" ,w       → Salvar
" ,q       → Sair
" ,wq      → Salvar e sair
" ,nh      → Limpar busca
"
" Ctrl-h   → Janela esquerda (tmux/vim)
" Ctrl-j   → Janela abaixo
" Ctrl-k   → Janela acima
" Ctrl-l   → Janela direita
"
" =============================================================================
