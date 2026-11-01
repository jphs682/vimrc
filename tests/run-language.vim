" Testa compilação e execução de um arquivo aberto pelo Vim.
set nomore

let s:filetype = &filetype
if empty(expand('%:p'))
    echomsg 'Arquivo de teste não foi aberto.'
    cquit
endif

if index(['python', 'javascript', 'typescript'], s:filetype) >= 0
    call assert_equal(0, BuildAndRunCurrentFile(), 'Falha ao executar ' . s:filetype)
else
    call assert_equal(0, CompileCurrentFile(), 'Falha ao compilar ' . s:filetype)
    if has('unix') && exists('b:vim_build_dir')
        call assert_equal('rwx------', getfperm(b:vim_build_dir), 'Permissões inseguras no diretório temporário')
    endif
    call assert_equal(0, RunCurrentFile(), 'Falha ao executar ' . s:filetype)
    call assert_false(exists('b:vim_build_dir'), 'Diretório temporário não foi limpo após executar')
endif

if !empty(v:errors)
    for s:error in v:errors
        echomsg s:error
    endfor
    cquit
endif

qa!
