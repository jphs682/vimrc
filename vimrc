" =============================================================================
" vimrc 1.0 — CONFIGURAÇÃO NATIVA, SEM PLUGINS
" =============================================================================
"
" Objetivo:
"   - Vim tradicional no Linux
"   - Nenhum plugin ou gerenciador de plugins
"   - Recursos nativos do Vimscript
"   - Configuração simples, portátil e fácil de manter
"
" Instalação:
"   1. Faça uma cópia do seu ~/.vimrc atual.
"   2. Copie este arquivo para ~/.vimrc.
"   3. Abra o Vim e execute: :source ~/.vimrc
"
" Observação:
"   Os comandos de execução dependem dos compiladores/intérpretes instalados
"   no sistema. O Vim não instala essas ferramentas.
"
" =============================================================================

" -----------------------------------------------------------------------------
" 1. INICIALIZAÇÃO
" -----------------------------------------------------------------------------

set nocompatible

let mapleader = ","
let maplocalleader = "\\"

set encoding=utf-8
scriptencoding utf-8

if has('termguicolors') && $TERM !=# 'dumb'
    set termguicolors
endif

set background=dark
syntax enable
filetype indent on

" -----------------------------------------------------------------------------
" 2. DIRETÓRIOS DE DADOS
" -----------------------------------------------------------------------------

let s:vim_data_dir = expand('~/.vim')
let s:undo_dir = s:vim_data_dir . '/undodir'
let s:swap_dir = s:vim_data_dir . '/swap'
let s:backup_dir = s:vim_data_dir . '/backup'

for s:dir in [s:vim_data_dir, s:undo_dir, s:swap_dir, s:backup_dir]
    if !isdirectory(s:dir)
        call mkdir(s:dir, 'p')
    endif
endfor
unlet s:dir

" -----------------------------------------------------------------------------
" 3. DESEMPENHO E INTERFACE
" -----------------------------------------------------------------------------

set updatetime=500
set timeout
set timeoutlen=500

set title
set ruler
set showcmd
set showmode
set laststatus=2
set noshowmatch

set number
set relativenumber
set cursorline
set scrolloff=5
set sidescrolloff=5

set nowrap
set linebreak
set splitbelow
set splitright

set mouse=a
set noerrorbells
set novisualbell
set shortmess+=I

" Barra de status nativa do Vim.
set statusline=%f\ %h%m%r%=%y\ %l:%c\ %p%%

" -----------------------------------------------------------------------------
" 4. ARQUIVOS, BACKUP E DESFAZER
" -----------------------------------------------------------------------------

set hidden
set autoread
set confirm
set backspace=indent,eol,start

set swapfile
let &directory = s:swap_dir . '//'

set backup
let &backupdir = s:backup_dir . '//'

if has('persistent_undo')
    set undofile
    let &undodir = s:undo_dir . '//'
    set undolevels=1000
    set undoreload=10000
endif

" -----------------------------------------------------------------------------
" 5. INDENTAÇÃO PADRÃO
" -----------------------------------------------------------------------------

set autoindent
set smartindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround

" -----------------------------------------------------------------------------
" 6. BUSCA E COMPLETAMENTO NATIVO
" -----------------------------------------------------------------------------

set ignorecase
set smartcase
set incsearch
set hlsearch

set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore=*.o,*~,*.pyc,*.class,*.so,*.swp
set wildignore+=node_modules/**,.git/**

set completeopt=menuone,noinsert,noselect

" -----------------------------------------------------------------------------
" 7. VISUALIZAÇÃO DE CARACTERES
" -----------------------------------------------------------------------------

set nolist
set listchars=tab:»\ ,trail:·,extends:»,precedes:«,nbsp:×

" -----------------------------------------------------------------------------
" 8. ÁREA DE TRANSFERÊNCIA
" -----------------------------------------------------------------------------

" Só ativa a opção quando o Vim foi compilado com suporte a clipboard.
" O funcionamento também depende de um provedor de clipboard no Linux.
if has('clipboard')
    set clipboard=unnamedplus
endif

" -----------------------------------------------------------------------------
" 9. HISTÓRICO E LIMITES
" -----------------------------------------------------------------------------

set history=1000
set maxmempattern=2000

" -----------------------------------------------------------------------------
" 10. CONFIGURAÇÕES POR TIPO DE ARQUIVO
" -----------------------------------------------------------------------------

augroup native_filetype_settings
    autocmd!
    autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab textwidth=88
    autocmd FileType c,cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab cindent
    autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4 softtabstop=4
    autocmd FileType rust setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
    autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType html,css setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType json,yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd FileType markdown setlocal spell spelllang=pt_br,en wrap linebreak nolist
    autocmd FileType gitcommit setlocal spell
augroup END

" -----------------------------------------------------------------------------
" 11. LIMPEZA DE ESPAÇOS NO FINAL DAS LINHAS
" -----------------------------------------------------------------------------

function! CleanExtraSpaces() abort
    if &modifiable && !&binary
        let l:view = winsaveview()
        let l:search = @/
        silent! %s/\s\+$//e
        let @/ = l:search
        call winrestview(l:view)
    endif
endfunction

augroup native_write_settings
    autocmd!
    autocmd BufWritePre * if &filetype !=# 'markdown' | call CleanExtraSpaces() | endif
    autocmd FocusGained,BufEnter * checktime
augroup END

" -----------------------------------------------------------------------------
" 12. RESTAURAR A POSIÇÃO DO CURSOR
" -----------------------------------------------------------------------------

augroup native_restore_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute "normal! g`\"" |
        \ endif
augroup END

" -----------------------------------------------------------------------------
" 13. COMANDOS ÚTEIS
" -----------------------------------------------------------------------------

command! FormatJSON %!python3 -m json.tool
command! ShowWhitespace setlocal list!
command! HideWhitespace setlocal nolist
command! ToggleRelativeNumber setlocal relativenumber!

" -----------------------------------------------------------------------------
" 14. BUFFERS
" -----------------------------------------------------------------------------

nnoremap <silent> <leader>bn :bnext<CR>
nnoremap <silent> <leader>bp :bprevious<CR>
nnoremap <silent> <leader>bd :bdelete<CR>
nnoremap <silent> <leader>bl :ls<CR>

" -----------------------------------------------------------------------------
" 15. JANELAS
" -----------------------------------------------------------------------------

nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Left> :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" -----------------------------------------------------------------------------
" 16. MOVIMENTO E EDIÇÃO
" -----------------------------------------------------------------------------

nnoremap j gj
nnoremap k gk

vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" -----------------------------------------------------------------------------
" 17. SALVAR, SAIR E BUSCA
" -----------------------------------------------------------------------------

nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>wq :write<Bar>quit<CR>
nnoremap <silent> <leader>nh :nohlsearch<CR>

" -----------------------------------------------------------------------------
" 18. ARQUIVOS E NAVEGAÇÃO NATIVA
" -----------------------------------------------------------------------------

nnoremap <leader>e :edit 
nnoremap <leader>o :browse oldfiles<CR>
nnoremap <leader>ls :ls<CR>

" -----------------------------------------------------------------------------
" 19. TERMINAL NATIVO (QUANDO DISPONÍVEL)
" -----------------------------------------------------------------------------

if has('terminal')
    nnoremap <silent> <leader>tt :terminal<CR>
    nnoremap <silent> <leader>tv :botright split<Bar>terminal<CR>
    nnoremap <silent> <leader>ts :botright vsplit<Bar>terminal<CR>
    tnoremap <Esc> <C-\><C-n>
endif

" -----------------------------------------------------------------------------
" 20. EXECUÇÃO DE ARQUIVOS
" -----------------------------------------------------------------------------

function! RunCurrentFile() abort
    if empty(expand('%:p'))
        echoerr 'Salve o arquivo antes de executá-lo.'
        return
    endif

    write
    let l:file = shellescape(expand('%:p'))
    let l:output = shellescape(expand('%:p:r') . '.out')

    if &filetype ==# 'python'
        execute '!python3 ' . l:file
    elseif &filetype ==# 'javascript'
        execute '!node ' . l:file
    elseif &filetype ==# 'typescript'
        if executable('ts-node')
            execute '!ts-node ' . l:file
        else
            echoerr 'ts-node não encontrado. Instale-o separadamente se desejar executar TypeScript.'
        endif
    elseif &filetype ==# 'go'
        execute '!go run ' . l:file
    elseif &filetype ==# 'c'
        execute '!gcc ' . l:file . ' -Wall -Wextra -o ' . l:output . ' && ' . l:output
    elseif &filetype ==# 'cpp'
        execute '!g++ ' . l:file . ' -std=c++17 -Wall -Wextra -o ' . l:output . ' && ' . l:output
    elseif &filetype ==# 'rust'
        execute '!rustc ' . l:file . ' -o ' . l:output . ' && ' . l:output
    else
        echoerr 'Tipo de arquivo sem comando de execução configurado.'
    endif
endfunction

nnoremap <silent> <leader>r :call RunCurrentFile()<CR>

" -----------------------------------------------------------------------------
" 21. GIT PELO TERMINAL
" -----------------------------------------------------------------------------

" Estes atalhos usam o executável git do sistema, não plugins do Vim.
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gl :!git log --oneline --decorate -10<CR>
nnoremap <leader>gd :!git diff<CR>

" -----------------------------------------------------------------------------
" 22. INFORMAÇÕES
" -----------------------------------------------------------------------------

command! VimInfo version

" =============================================================================
" FIM — CONFIGURAÇÃO NATIVA, SEM PLUGINS
" =============================================================================
