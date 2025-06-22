" =============================================================================
" CONFIGURAÇÃO INICIAL
" =============================================================================

" Ativação de recursos avançados
if has('termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
else
    set t_Co=256
endif

" Desativa compatibilidade com Vi
set nocompatible

" =============================================================================
" GERENCIAMENTO DE PLUGINS (VIM-PLUG)
" =============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Temas e Interface
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Produtividade
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletar inteligente
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive' " Integração com Git
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify' " Tela inicial personalizada

" Linguagens e Syntax
Plug 'sheerun/vim-polyglot' " Suporte avançado para múltiplas linguagens
Plug 'dense-analysis/ale' " Linting assíncrono

" Ferramentas Úteis
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround' " Manipulação de surroundings
Plug 'jiangmiao/auto-pairs' " Autocompletar pares
Plug 'christoomey/vim-tmux-navigator' " Navegação entre tmux/vim

call plug#end()

" =============================================================================
" CONFIGURAÇÕES ESSENCIAIS
" =============================================================================

" Performance
set lazyredraw
set ttyfast
set updatetime=300

" Configurações básicas
filetype plugin indent on
syntax enable
set encoding=utf-8
set title
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden
set splitbelow
set splitright
set fillchars=vert:│,fold:-,eob:~
set path=.,**
set noswapfile
set nobackup
set nowrap
set linebreak
set nolist
set listchars=tab:»\ ,trail:·,extends:»,precedes:«,nbsp:×

" Números e cursor
set number
set relativenumber
set scrolloff=5
set sidescrolloff=5
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
set shiftround

" Busca
set ignorecase
set smartcase
set incsearch
set hlsearch

" Autocompletar
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.o,*~,*.pyc

" =============================================================================
" CONFIGURAÇÃO DE PLUGINS
" =============================================================================

" Tema Gruvbox
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_italic = 1
colorscheme gruvbox
set background=dark

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'gruvbox'

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.swp$']
nmap <C-n> :NERDTreeToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>

" FZF
nmap <C-p> :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :History<CR>
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" CoC (Autocompletar Inteligente)
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-clangd',
  \ 'coc-go',
  \ 'coc-snippets',
  \ 'coc-prettier',
  \ 'coc-eslint'
  \ ]

" Atalhos CoC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Undotree
nnoremap <F5> :UndotreeToggle<CR>

" GitGutter
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▔'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'

" =============================================================================
" ATALHOS PERSONALIZADOS
" =============================================================================

" Líder
let mapleader = ","

" Navegação entre buffers
nnoremap <silent> <C-h> :bprev<CR>
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <leader>bd :bd<CR>

" Movimento visual entre linhas embrulhadas
nnoremap j gj
nnoremap k gk

" Ajustes de tamanho de janela
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" Limpar highlight de busca
nnoremap <silent> <leader>nh :noh<CR>

" Fechamento rápido
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>

" Terminal
nnoremap <leader>tt :terminal<CR>

" =============================================================================
" FUNÇÕES PERSONALIZADAS
" =============================================================================

" Format JSON
com! FormatJSON %!python -m json.tool

" Limpar espaços em branco
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre * :call CleanExtraSpaces()

" =============================================================================
" CONFIGURAÇÕES ESPECÍFICAS POR LINGUAGEM
" =============================================================================

" Python
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType python nnoremap <buffer> <leader>r :exec '!python' shellescape(@%, 1)<CR>

" JavaScript/TypeScript
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2

" HTML/CSS
autocmd FileType html,css setlocal shiftwidth=2 tabstop=2

" Markdown
autocmd FileType markdown setlocal spell spelllang=pt_br,en
autocmd FileType markdown setlocal wrap linebreak nolist

" =============================================================================
" CONFIGURAÇÃO FINAL
" =============================================================================

" Habilita o mouse em todos os modos
set mouse=a

" Suporte para clipboard do sistema
set clipboard=unnamedplus

" Persistência de histórico
set history=1000
set undofile
set undodir=~/.vim/undodir

" Atualização automática de arquivos
set autoread
autocmd FocusGained,BufEnter * :checktime

" Mensagem de status personalizada
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" Highlight de yank
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=300}
augroup END
