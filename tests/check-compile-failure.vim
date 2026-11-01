" Verifica se uma compilação inválida falha e remove o diretório temporário.
set nomore

let s:status = CompileCurrentFile()
call assert_notequal(0, s:status, 'A compilação de código inválido deveria falhar')
call assert_false(exists('b:vim_build_dir'), 'Diretório temporário não foi removido após falha')

if !empty(v:errors)
    for s:error in v:errors
        echomsg s:error
    endfor
    cquit
endif

qa!
