" Testes básicos da configuração vimrc 1.3.0.
set nomore

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

set number relativenumber
call ToggleNumberMode()
call assert_true(&number && !&relativenumber)
call ToggleNumberMode()
call assert_false(&number || &relativenumber)
call ToggleNumberMode()
call assert_true(&number && &relativenumber)

enew!
setlocal filetype=python
call setline(1, 'print("teste")')
1,1call ToggleCommentLines()
call assert_equal('# print("teste")', getline(1))
1,1call ToggleCommentLines()
call assert_equal('print("teste")', getline(1))

enew!
filetype on
setlocal filetype=java
file /tmp/ModeloTeste.java
call InsertFileTemplate()
call assert_equal('public class ModeloTeste {', getline(1))
call assert_equal('}', getline('$'))

if !empty(v:errors)
    for s:error in v:errors
        echomsg s:error
    endfor
    cquit
endif

qa!
