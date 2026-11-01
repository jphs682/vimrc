" =============================================================================
" vimrc 1.1 — CONFIGURAÇÃO NATIVA, SEM PLUGINS
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
"   Os comandos de execução verificam as ferramentas necessárias.
"   Binários compilados são guardados em diretórios temporários e removidos
"   após a execução. O Vim não instala compiladores ou intérpretes.
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

function! FormatCurrentJSON() abort
    if !executable('python3')
        echoerr 'python3 não encontrado. Instale o Python 3 para formatar JSON.'
        return
    endif

    let l:formatted = system('python3 -m json.tool', join(getline(1, '
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
    let l:build_dir = ''
    let l:output = ''

    if &filetype ==# 'python'
        if !executable('python3')
            echoerr 'python3 não encontrado.'
            return
        endif
        execute '!python3 ' . l:file

    elseif &filetype ==# 'javascript'
        if !executable('node')
            echoerr 'Node.js (node) não encontrado.'
            return
        endif
        execute '!node ' . l:file

    elseif &filetype ==# 'typescript'
        if !executable('ts-node')
            echoerr 'ts-node não encontrado. Instale-o separadamente para executar TypeScript.'
            return
        endif
        execute '!ts-node ' . l:file

    elseif &filetype ==# 'go'
        if !executable('go')
            echoerr 'Go (go) não encontrado.'
            return
        endif
        execute '!go run ' . l:file

    elseif &filetype ==# 'java'
        if !executable('javac') || !executable('java')
            echoerr 'JDK não encontrado. Verifique se javac e java estão no PATH.'
            return
        endif

        let l:source = join(readfile(expand('%:p')), "\n")
        let l:package = matchlist(l:source, '^\s*package\s\+\([A-Za-z_][A-Za-z0-9_.]*\)\s*;')
        let l:class_name = expand('%:t:r')
        if !empty(l:package)
            let l:class_name = l:package[1] . '.' . l:class_name
        endif

        let l:build_dir = tempname()
        call mkdir(l:build_dir, 'p')
        execute '!javac -d ' . shellescape(l:build_dir) . ' ' . l:file
            \ . ' && java -cp ' . shellescape(l:build_dir) . ' '
            \ . shellescape(l:class_name)
        call delete(l:build_dir, 'rf')

    elseif &filetype ==# 'c'
        if !executable('gcc')
            echoerr 'gcc não encontrado.'
            return
        endif
        let l:build_dir = tempname()
        call mkdir(l:build_dir, 'p')
        let l:output = l:build_dir . '/program'
        execute '!gcc ' . l:file . ' -Wall -Wextra -o ' . shellescape(l:output)
            \ . ' && ' . shellescape(l:output)
        call delete(l:build_dir, 'rf')

    elseif &filetype ==# 'cpp'
        if !executable('g++')
            echoerr 'g++ não encontrado.'
            return
        endif
        let l:build_dir = tempname()
        call mkdir(l:build_dir, 'p')
        let l:output = l:build_dir . '/program'
        execute '!g++ ' . l:file . ' -std=c++17 -Wall -Wextra -o ' . shellescape(l:output)
            \ . ' && ' . shellescape(l:output)
        call delete(l:build_dir, 'rf')

    elseif &filetype ==# 'rust'
        if !executable('rustc')
            echoerr 'rustc não encontrado.'
            return
        endif
        let l:build_dir = tempname()
        call mkdir(l:build_dir, 'p')
        let l:output = l:build_dir . '/program'
        execute '!rustc ' . l:file . ' -o ' . shellescape(l:output)
            \ . ' && ' . shellescape(l:output)
        call delete(l:build_dir, 'rf')

    else
        echoerr 'Tipo de arquivo sem comando de execução configurado.'
    endif
endfunction

nnoremap <silent> <leader>r :call RunCurrentFile()<CR>

" -----------------------------------------------------------------------------
" 21. GIT PELO TERMINAL
" -----------------------------------------------------------------------------

" Os atalhos verificam se o Git está instalado e se o diretório pertence
" a um repositório (inclusive subdiretórios e worktrees).
function! GitCommand(command) abort
    if !executable('git')
        echoerr 'Git não encontrado. Instale o Git e verifique o PATH.'
        return
    endif

    call system('git rev-parse --show-toplevel 2>/dev/null')
    if v:shell_error
        echoerr 'Este diretório não pertence a um repositório Git.'
        return
    endif

    execute '!' . a:command
endfunction

nnoremap <silent> <leader>gs :call GitCommand('git status')<CR>
nnoremap <silent> <leader>gl :call GitCommand('git log --oneline --decorate -10')<CR>
nnoremap <silent> <leader>gd :call GitCommand('git diff')<CR>

" 22. INFORMAÇÕES
" -----------------------------------------------------------------------------

command! VimInfo version

" =============================================================================
" FIM — CONFIGURAÇÃO NATIVA, SEM PLUGINS
" =============================================================================
), "\n"))
    if v:shell_error
        echoerr 'JSON inválido. O conteúdo original foi preservado.'
        return
    endif

    let l:lines = split(substitute(l:formatted, "\n\+$", '', ''), "\n")
    call setline(1, l:lines)
    if line('
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
) > len(l:lines)
        execute (len(l:lines) + 1) . ',$delete _'
    endif
endfunction

command! FormatJSON call FormatCurrentJSON()
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
