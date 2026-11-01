" =============================================================================
" vimrc 1.2.0 — CONFIGURAÇÃO NATIVA, SEM PLUGINS
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

    " Formata em memória primeiro: em caso de erro, o buffer permanece intacto.
    let l:input = join(getline(1, '$'), "\n") . "\n"
    let l:formatted = system('python3 -m json.tool', l:input)

    if v:shell_error != 0 || empty(l:formatted)
        echoerr 'JSON inválido ou falha ao executar o formatador. O conteúdo original foi preservado.'
        return
    endif

    let l:lines = split(substitute(l:formatted, "\n\+$", '', ''), "\n")
    if empty(l:lines)
        echoerr 'O formatador não retornou conteúdo. O buffer original foi preservado.'
        return
    endif

    let l:view = winsaveview()
    call setline(1, l:lines)

    if line('$') > len(l:lines)
        execute (len(l:lines) + 1) . ',$delete _'
    endif

    call winrestview(l:view)
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
" 20. COMPILAÇÃO E EXECUÇÃO
" -----------------------------------------------------------------------------

" Executa comandos externos de forma uniforme e devolve o código de saída.
function! s:RunShellCommand(command) abort
    execute '!' . a:command
    return v:shell_error
endfunction

function! s:RequireExecutable(binary, label) abort
    if !executable(a:binary)
        echoerr a:label . ' não encontrado. Instale-o e verifique se está no PATH.'
        return 0
    endif
    return 1
endfunction

" Cada buffer mantém seus artefatos em um diretório temporário próprio.
function! s:GetBuildDirectory() abort
    if !exists('b:vim_build_dir') || empty(b:vim_build_dir)
        let b:vim_build_dir = tempname()
    endif

    if isdirectory(b:vim_build_dir)
        call delete(b:vim_build_dir, 'rf')
    endif
    call mkdir(b:vim_build_dir, 'p')
    return b:vim_build_dir
endfunction

function! s:CleanupCurrentBuild() abort
    if exists('b:vim_build_dir') && !empty(b:vim_build_dir)
        if isdirectory(b:vim_build_dir)
            call delete(b:vim_build_dir, 'rf')
        endif
    endif
    unlet! b:vim_build_dir b:vim_build_output b:vim_build_class
endfunction

function! s:CleanupBufferBuild(bufnr) abort
    let l:dir = getbufvar(a:bufnr, 'vim_build_dir', '')
    if !empty(l:dir) && isdirectory(l:dir)
        call delete(l:dir, 'rf')
    endif
    call setbufvar(a:bufnr, 'vim_build_dir', '')
endfunction

augroup native_build_cleanup
    autocmd!
    autocmd BufWipeout * call s:CleanupBufferBuild(str2nr(expand('<abuf>')))
    autocmd VimLeavePre * for s:buf in getbufinfo() | call s:CleanupBufferBuild(s:buf.bufnr) | endfor
augroup END

function! CompileCurrentFile() abort
    if empty(expand('%:p'))
        echoerr 'Salve o arquivo antes de compilá-lo.'
        return 1
    endif

    if &modified
        write
    endif

    let l:file = expand('%:p')
    let l:shell_file = shellescape(l:file)
    let l:dir = s:GetBuildDirectory()
    let l:output = l:dir . '/program'
    let b:vim_build_output = l:output
    let l:command = ''

    if &filetype ==# 'c'
        if !s:RequireExecutable('gcc', 'gcc')
            call s:CleanupCurrentBuild()
            return 1
        endif
        let l:command = 'gcc -Wall -Wextra ' . l:shell_file . ' -o ' . shellescape(l:output)

    elseif &filetype ==# 'cpp'
        if !s:RequireExecutable('g++', 'g++')
            call s:CleanupCurrentBuild()
            return 1
        endif
        let l:command = 'g++ -std=c++17 -Wall -Wextra ' . l:shell_file . ' -o ' . shellescape(l:output)

    elseif &filetype ==# 'rust'
        if !s:RequireExecutable('rustc', 'rustc')
            call s:CleanupCurrentBuild()
            return 1
        endif
        let l:command = 'rustc ' . l:shell_file . ' -o ' . shellescape(l:output)

    elseif &filetype ==# 'go'
        if !s:RequireExecutable('go', 'Go (go)')
            call s:CleanupCurrentBuild()
            return 1
        endif
        let l:command = 'go build -o ' . shellescape(l:output) . ' ' . l:shell_file

    elseif &filetype ==# 'java'
        if !s:RequireExecutable('javac', 'javac') || !s:RequireExecutable('java', 'java')
            call s:CleanupCurrentBuild()
            return 1
        endif

        " Compila os arquivos Java do mesmo diretório para permitir classes auxiliares.
        let l:java_files = globpath(expand('%:p:h'), '*.java', 0, 1)
        if empty(l:java_files)
            let l:java_files = [l:file]
        endif
        let l:sources = join(map(copy(l:java_files), 'shellescape(v:val)'), ' ')
        let l:source = join(readfile(l:file), "\n")
        let l:package = matchstr(l:source, '\mpackage\s\+\zs[A-Za-z_][A-Za-z0-9_.]*\ze\s*;')
        let b:vim_build_class = (empty(l:package) ? '' : l:package . '.') . expand('%:t:r')
        let l:command = 'javac -d ' . shellescape(l:dir) . ' ' . l:sources

    elseif index(['python', 'javascript', 'typescript'], &filetype) >= 0
        echo 'Este tipo de arquivo é interpretado; use :RunCurrentFile para executá-lo.'
        call s:CleanupCurrentBuild()
        return 0

    else
        echoerr 'Tipo de arquivo sem comando de compilação configurado.'
        call s:CleanupCurrentBuild()
        return 1
    endif

    echo 'Compilando ' . expand('%:t') . '...'
    if s:RunShellCommand(l:command) != 0
        call s:CleanupCurrentBuild()
        echoerr 'A compilação falhou. Consulte as mensagens do compilador acima.'
        return 1
    endif

    echo 'Compilação concluída: ' . expand('%:t')
    return 0
endfunction

function! RunCurrentFile() abort
    if empty(expand('%:p'))
        echoerr 'Salve o arquivo antes de executá-lo.'
        return 1
    endif

    if &modified
        write
    endif

    let l:file = shellescape(expand('%:p'))
    let l:command = ''

    if &filetype ==# 'python'
        if !s:RequireExecutable('python3', 'Python 3')
            return 1
        endif
        let l:command = 'python3 ' . l:file

    elseif &filetype ==# 'javascript'
        if !s:RequireExecutable('node', 'Node.js (node)')
            return 1
        endif
        let l:command = 'node ' . l:file

    elseif &filetype ==# 'typescript'
        if !s:RequireExecutable('ts-node', 'ts-node')
            return 1
        endif
        let l:command = 'ts-node ' . l:file

    elseif index(['c', 'cpp', 'rust', 'go'], &filetype) >= 0
        if !exists('b:vim_build_output') || !filereadable(b:vim_build_output)
            echoerr 'Programa não compilado. Execute :CompileCurrentFile primeiro.'
            return 1
        endif
        let l:command = shellescape(b:vim_build_output)

    elseif &filetype ==# 'java'
        if !s:RequireExecutable('java', 'java')
            return 1
        endif
        if !exists('b:vim_build_dir') || !exists('b:vim_build_class')
            echoerr 'Classes Java não compiladas. Execute :CompileCurrentFile primeiro.'
            return 1
        endif
        let l:command = 'java -cp ' . shellescape(b:vim_build_dir) . ' ' . shellescape(b:vim_build_class)

    else
        echoerr 'Tipo de arquivo sem comando de execução configurado.'
        return 1
    endif

    let l:status = s:RunShellCommand(l:command)
    call s:CleanupCurrentBuild()
    return l:status
endfunction

function! BuildAndRunCurrentFile() abort
    if index(['python', 'javascript', 'typescript'], &filetype) >= 0
        return RunCurrentFile()
    endif

    if CompileCurrentFile() != 0
        return 1
    endif
    return RunCurrentFile()
endfunction

command! CompileCurrentFile call CompileCurrentFile()
command! RunCurrentFile call RunCurrentFile()
command! BuildAndRunCurrentFile call BuildAndRunCurrentFile()

nnoremap <silent> <leader>c :call CompileCurrentFile()<CR>
nnoremap <silent> <leader>R :call RunCurrentFile()<CR>
nnoremap <silent> <leader>r :call BuildAndRunCurrentFile()<CR>

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
