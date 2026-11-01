# Vimrc 2.0.0 — Vim nativo, sem plugins

Configuração pessoal do Vim tradicional, com prioridade para Linux. O projeto usa Vimscript e recursos nativos do editor: não instala plugins, gerenciadores de plugins, LSPs ou extensões.

- **Versão:** 2.0.0
- **Compatibilidade mínima declarada:** Vim 8.2
- **Ambientes de CI:** Ubuntu 22.04 e Ubuntu 24.04
- **Licença:** MIT

## Princípios

- Vim tradicional, sem plugins de terceiros.
- Configuração legível e organizada por seções.
- Comandos externos com executáveis verificados e caminhos escapados.
- Binários e classes gerados fora da pasta do projeto.
- Testes automatizados para configuração, edição, compilação e execução.

## Requisitos

### Obrigatório

- Vim 8.2 ou superior.
- Linux recomendado.

### Dependências opcionais

Instale somente as ferramentas das linguagens e recursos que pretende utilizar.

| Executável | Recurso |
|---|---|
| `python3` | Executar Python e formatar JSON |
| `node` | Executar JavaScript |
| `ts-node` | Executar TypeScript |
| `gcc` | Compilar C |
| `g++` | Compilar C++17 |
| `rustc` | Compilar Rust |
| `go` | Compilar programas Go de arquivo único |
| `javac` e `java` | Compilar e executar Java |
| `git` | Atalhos de status, log e diff |

Recursos adicionais dependem da compilação do Vim e do ambiente:

- **Terminal integrado:** requer `+terminal`.
- **Área de transferência:** requer `+clipboard` e um provedor disponível no sistema, como `xclip` ou `xsel`.
- **Verificação ortográfica:** requer dicionários do Vim para os idiomas configurados.

## Instalação

Faça backup da configuração atual:

~~~sh
[ ! -f ~/.vimrc ] || cp ~/.vimrc ~/.vimrc.backup
~~~

Clone o repositório e instale:

~~~sh
git clone https://github.com/jphs682/vimrc.git ~/.vim-config
cp ~/.vim-config/vimrc ~/.vimrc
~~~

Abra o Vim. Para testar sem substituir sua configuração pessoal:

~~~sh
vim -Nu ~/.vim-config/vimrc
~~~

Confira versão e recursos compilados:

~~~sh
vim --version
~~~

## Atalhos

A tecla líder é a vírgula. Por exemplo, `,w` significa pressionar vírgula e depois w.

### Arquivos e buffers

| Atalho | Ação |
|---|---|
| `,e` | Iniciar `:edit` |
| `,f` | Iniciar `:find` usando o caminho recursivo |
| `,o` | Abrir a lista de arquivos recentes |
| `,w` | Salvar |
| `,q` | Sair |
| `,wq` | Salvar e sair |
| `,bn` | Próximo buffer |
| `,bp` | Buffer anterior |
| `,bd` | Fechar buffer |
| `,bl` ou `,ls` | Listar buffers |

### Navegação e edição

| Atalho | Ação |
|---|---|
| `,h`, `,j`, `,k`, `,l` | Mover entre janelas |
| Ctrl + setas | Redimensionar janela |
| `,n` | Alternar números relativos, absolutos e ocultos |
| `,g` | Pesquisar texto no projeto com `vimgrep` |
| `,cc` | Comentar/descomentar linha ou seleção |
| `,t` | Inserir modelo em buffer vazio |
| `,nh` | Limpar destaque da busca |
| Visual `<` / `>` | Indentar mantendo a seleção |
| Visual `J` / `K` | Mover linhas selecionadas |

### Compilação e execução

| Atalho | Ação |
|---|---|
| `,c` | Compilar C, C++, Rust, Go ou Java |
| `,R` | Executar o programa compilado ou script |
| `,r` | Compilar e executar; para linguagens interpretadas, executar diretamente |

### Terminal e Git

| Atalho | Ação |
|---|---|
| `,tt` | Abrir terminal |
| `,tv` | Abrir terminal em divisão horizontal |
| `,ts` | Abrir terminal em divisão vertical |
| Esc no modo Terminal | Voltar ao modo Normal |
| `,gs` | Git status |
| `,gl` | Últimos 10 commits |
| `,gd` | Git diff |

Os atalhos de terminal só são definidos quando o Vim oferece `+terminal`. Os atalhos Git verificam se o executável está disponível e se o diretório atual pertence a um repositório.

## Comandos

| Comando | Ação |
|---|---|
| `:FormatJSON` | Validar e formatar JSON com Python 3 |
| `:ShowWhitespace` | Mostrar espaços e caracteres especiais |
| `:HideWhitespace` | Ocultar espaços e caracteres especiais |
| `:ToggleRelativeNumber` | Alternar numeração relativa |
| `:ToggleNumberMode` | Alternar entre três modos de numeração |
| `:ProjectSearch` | Pesquisar texto nos arquivos do projeto |
| `:InsertTemplate` | Inserir modelo de código |
| `:FileInfo` | Exibir informações do arquivo atual |
| `:CompileCurrentFile` | Compilar arquivo compatível |
| `:RunCurrentFile` | Executar arquivo ou binário já compilado |
| `:BuildAndRunCurrentFile` | Compilar e executar |
| `:VimInfo` | Mostrar versão e recursos do Vim |

A formatação JSON valida o conteúdo antes de substituir o buffer. Se o JSON for inválido ou o Python 3 falhar, o texto original é preservado.

## Compilação e execução

Salve o arquivo antes de compilar ou executar. O comando `,r` é o fluxo recomendado para uso cotidiano.

| Tipo | Comando externo |
|---|---|
| Python | `python3 arquivo.py` |
| JavaScript | `node arquivo.js` |
| TypeScript | `ts-node arquivo.ts` |
| C | `gcc -Wall -Wextra` |
| C++ | `g++ -std=c++17 -Wall -Wextra` |
| Rust | `rustc` |
| Go | `go build` para o arquivo atual |
| Java | `javac` e depois `java` |

Para linguagens compiladas, `,c` compila e `,R` executa o artefato da compilação atual. Se o fonte mudar depois da compilação, compile novamente antes de executar.

### Java

- O nome do arquivo deve corresponder à classe principal. Exemplo: `Aluno.java` e `public class Aluno`.
- Os arquivos `.java` no mesmo diretório do arquivo atual são compilados juntos, permitindo classes auxiliares locais.
- A declaração `package` do arquivo principal é considerada ao executar a classe.
- Projetos com dependências externas, múltiplos módulos ou Maven/Gradle devem ser executados pelas ferramentas próprias do projeto.

### Arquivos temporários

Executáveis e classes são criados em diretórios temporários exclusivos por buffer, fora da pasta do projeto. No Linux, os diretórios são criados com permissão restrita ao usuário (`0700`). A configuração tenta removê-los após executar, fechar o buffer ou sair normalmente do Vim. Encerramentos forçados podem deixar resíduos temporários.

## Segurança e limitações

- Caminhos de arquivos são escapados antes de serem enviados ao shell.
- Os comandos de compilação usam argumentos definidos pela configuração; os atalhos Git também usam argumentos fixos.
- O diretório temporário é criado sem apagar um caminho preexistente.
- A configuração não tenta sandboxar programas. **Executar um arquivo significa executar o código dele com as permissões do seu usuário.** Não execute código desconhecido ou não confiável.
- A pesquisa de projeto usa expressões regulares Vim e pesquisa arquivos sob o diretório de trabalho atual.
- A compilação Go é voltada a arquivos individuais; projetos com vários pacotes devem usar `go build`/ `go test` no terminal.
- A configuração não substitui ferramentas de build de projetos complexos.

## Testes automatizados

O repositório contém testes da configuração e testes de integração para as linguagens cujas ferramentas estão instaladas.

~~~sh
sh tests/run.sh
~~~

A suíte verifica recursos do Vimscript, formatação JSON, caminhos com espaços e caracteres especiais, compilação e execução, classes auxiliares Java e limpeza de diretórios temporários. O teste de TypeScript é executado apenas quando o `ts-node` instalado responde corretamente.

O GitHub Actions executa a suíte em Ubuntu 22.04 e 24.04. A matriz valida a compatibilidade mínima declarada, Vim 8.2 ou superior, nas versões fornecidas por essas distribuições.

## Solução de problemas

### A configuração apresenta erro ao carregar

~~~sh
vim -Nu ~/.vim-config/vimrc --noplugin -n -es -c 'qa!'
~~~

Para investigar no Vim:

~~~vim
:messages
:VimInfo
~~~

### Um compilador não foi encontrado

Confira se o executável está no `PATH`:

~~~sh
command -v python3
command -v node
command -v ts-node
command -v gcc
command -v g++
command -v rustc
command -v go
command -v javac
command -v java
command -v git
~~~

### O terminal integrado não abre

Confira se `vim --version` mostra `+terminal`.

### A área de transferência não funciona

Confira se o Vim possui `+clipboard` e se há um provedor de clipboard instalado.

## Licença

Distribuído sob a licença MIT. Consulte [LICENSE](LICENSE).

## Filosofia

Este projeto prioriza simplicidade, previsibilidade e manutenção. Ele aproveita os recursos nativos do Vim e deixa compiladores, intérpretes e Git como ferramentas externas do sistema. Nenhum plugin é necessário.
