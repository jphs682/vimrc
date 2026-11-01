" Testes funcionais da configuração vimrc 2.0.0.
set nomore

if v:version < 802
    echomsg "Vim 8.2 ou superior é obrigatório."
    cquit
endif

let s:required_commands = [
            \ 'FormatJSON',
            \ 'CompileCurrentFile',
            \ 'RunCurrentFile',
            \ 'BuildAndRunCurrentFile',
            \ 'ToggleNumberMode',
            \ 'ProjectSearch',
            \ 'InsertTemplate',
            \ 'FileInfo'
            \ ]

for s:command in s:required_commands
    call assert_equal(2, exists(':' . s:command), 'Comando ausente: ' . s:command)
endfor

call assert_equal(1, exists('*ToggleCommentLines'))
call assert_equal(1, exists('*InsertFileTemplate'))
call assert_equal(1, exists('*ShowFileInfo'))
call assert_equal(0, exists(':PlugInstall'), 'A configuração não deve instalar plugins.')

" Alternância dos três modos de numeração.
set number relativenumber
call ToggleNumberMode()
call assert_true(&number && !&relativenumber)
call ToggleNumberMode()
call assert_false(&number || &relativenumber)
call ToggleNumberMode()
call assert_true(&number && &relativenumber)

" Comentários: comentar e descomentar sem perder indentação.
enew!
setlocal filetype=python
call setline(1, '    print("teste")')
1,1call ToggleCommentLines()
call assert_equal('    # print("teste")', getline(1))
1,1call ToggleCommentLines()
call assert_equal('    print("teste")', getline(1))

" Modelo Java com nome derivado do arquivo.
enew!
execute 'file ' . fnameescape('/tmp/ModeloTeste.java')
setlocal filetype=java
call InsertFileTemplate()
call assert_equal('public class ModeloTeste {', getline(1))
call assert_equal('}', getline('$'))

" Comandos de espaços devem ter semântica explícita.
setlocal nolist
ShowWhitespace
call assert_true(&l:list)
HideWhitespace
call assert_false(&l:list)

" Formatação JSON válida.
enew!
setlocal filetype=json
call setline(1, ['{"nome":"Ana","nota":10}'])
call FormatCurrentJSON()
call assert_equal('{', getline(1))
call assert_match('"nome": "Ana"', getline(2))
call assert_match('"nota": 10', getline(3))
call assert_equal('}', getline(4))

" JSON inválido deve preservar o buffer original.
enew!
setlocal filetype=json
call setline(1, ['{"nome": }'])
let s:invalid_json_before = getline(1, '$')
silent! call FormatCurrentJSON()
call assert_equal(s:invalid_json_before, getline(1, '$'))

if !empty(v:errors)
    for s:error in v:errors
        echomsg s:error
    endfor
    cquit
endif

qa!
