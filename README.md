# Vimrc 1.1.1 — Vim nativo, sem plugins

Configuração para o **Vim tradicional**, com prioridade para Linux, usando somente recursos nativos do Vim e Vimscript.

O objetivo é oferecer uma configuração organizada para edição e programação, sem gerenciadores de plugins, extensões de terceiros ou dependência de IDE.

## Características

- Nenhum plugin ou gerenciador de plugins.
- Interface com números de linha, linha do cursor, barra de status e divisão de janelas.
- Backup, arquivos swap e undo persistente.
- Busca incremental e diferenciação entre maiúsculas e minúsculas.
- Indentação padrão de quatro espaços, com ajustes por tipo de arquivo.
- Configurações específicas para Python, C, C++, Go, Rust, JavaScript, TypeScript, HTML, CSS, JSON, YAML e Markdown.
- Navegação por buffers e janelas.
- Terminal integrado nativo, quando disponível na compilação do Vim.
- Execução de scripts e compilação de programas pelo atalho ,r.
- Atalhos Git nativos, com verificação de repositório.
- Formatação de JSON com Python 3.

## Requisitos

### Obrigatório

- Vim instalado.
- Sistema Linux recomendado.

### Dependências opcionais por funcionalidade

O Vim não instala compiladores ou intérpretes. Instale apenas as ferramentas das linguagens que pretende executar:

| Ferramenta | Utilização |
|---|---|
| python3 | Executar Python e formatar JSON |
| node | Executar JavaScript |
| ts-node | Executar TypeScript |
| go | Executar programas Go |
| gcc | Compilar e executar C |
| g++ | Compilar e executar C++17 |
| rustc | Compilar e executar Rust |
| JDK (javac e java) | Compilar e executar Java |
| git | Atalhos de status, log e diff |

Alguns recursos dependem também da compilação do Vim e do ambiente:

- **Terminal integrado:** requer Vim compilado com suporte a terminal (+terminal).
- **Área de transferência:** requer suporte a clipboard no Vim e um provedor disponível no Linux, como xclip ou xsel.
- **Verificação ortográfica:** o Markdown usa português e inglês; os arquivos de dicionário correspondentes precisam estar instalados no Vim.

## Instalação

Faça uma cópia da configuração atual antes de substituí-la:

~~~bash
[ -f ~/.vimrc ] && cp ~/.vimrc ~/.vimrc.backup
~~~

Clone o repositório e instale o arquivo:

~~~bash
git clone https://github.com/jphs682/vimrc.git ~/.vim-config
cp ~/.vim-config/vimrc ~/.vimrc
~~~

Carregue a configuração sem fechar o Vim:

~~~vim
:source ~/.vimrc
~~~

Para conferir a versão e os recursos disponíveis na sua instalação:

~~~bash
vim --version
~~~

> Se preferir manter o arquivo em outro local, use vim -u /caminho/para/vimrc. O arquivo do repositório é chamado vimrc, sem ponto inicial.

## Atalhos

A tecla líder (Leader) é a vírgula. Por isso, Leader+w significa pressionar vírgula e depois w.

### Arquivos e buffers

| Atalho | Ação |
|---|---|
| ,w | Salvar arquivo |
| ,q | Sair |
| ,wq | Salvar e sair |
| ,e | Iniciar comando para abrir arquivo |
| ,o | Abrir lista de arquivos recentes |
| ,bn | Próximo buffer |
| ,bp | Buffer anterior |
| ,bd | Fechar buffer |
| ,bl | Listar buffers |
| ,ls | Listar buffers |

### Janelas

| Atalho | Ação |
|---|---|
| ,h | Mover para janela à esquerda |
| ,j | Mover para janela abaixo |
| ,k | Mover para janela acima |
| ,l | Mover para janela à direita |
| Ctrl + setas | Redimensionar janela |

### Edição e busca

| Atalho | Ação |
|---|---|
| ,nh | Limpar destaque da busca |
| j / k | Navegar por linhas visuais quando há quebra de linha |
| > / < no modo Visual | Indentar seleção mantendo-a selecionada |
| J / K no modo Visual | Mover linhas selecionadas para baixo/cima |

### Terminal e execução

| Atalho | Ação |
|---|---|
| ,tt | Abrir terminal |
| ,tv | Abrir terminal em divisão horizontal |
| ,ts | Abrir terminal em divisão vertical |
| Esc no modo Terminal | Voltar ao modo Normal |
| ,r | Executar o arquivo atual, conforme o tipo |

### Git

| Atalho | Ação |
|---|---|
| ,gs | Executar git status |
| ,gl | Mostrar os últimos 10 commits |
| ,gd | Mostrar git diff |

Os atalhos Git funcionam dentro de um repositório, inclusive em seus subdiretórios. O Git precisa estar instalado.

## Comandos disponíveis

| Comando | Ação |
|---|---|
| :FormatJSON | Formatar o JSON do buffer usando Python 3 |
| :ShowWhitespace | Alternar visualização de espaços e caracteres especiais |
| :HideWhitespace | Ocultar caracteres especiais |
| :ToggleRelativeNumber | Alternar números relativos |
| :VimInfo | Exibir informações da versão do Vim |

A formatação valida o JSON antes de alterar o buffer. Se o JSON for inválido, o Python 3 não estiver disponível ou o formatador falhar, a configuração informa o erro e preserva o conteúdo original.

## Execução de linguagens

Salve o arquivo e pressione ,r.

| Tipo de arquivo | Comando utilizado |
|---|---|
| Python | python3 arquivo.py |
| JavaScript | node arquivo.js |
| TypeScript | ts-node arquivo.ts |
| Go | go run arquivo.go |
| C | gcc com avisos -Wall -Wextra |
| C++ | g++ -std=c++17 com avisos |
| Rust | rustc |
| Java | javac e depois java |

### Observações sobre Java

- O JDK precisa disponibilizar os comandos javac e java no PATH.
- Para a execução simples, o nome do arquivo deve corresponder ao nome da classe principal. Exemplo: Aluno.java com a classe Aluno.
- A função reconhece uma declaração simples de pacote (package) e usa o nome qualificado da classe ao executar.
- O código precisa conter um método de entrada válido, normalmente public static void main(String[] args).
- Projetos Java com várias classes, dependências externas ou configuração de build (Maven/Gradle) devem ser executados pelas ferramentas próprias do projeto.

### Arquivos compilados

Os executáveis de C, C++ e Rust e os arquivos compilados de Java são criados em diretórios temporários. A configuração tenta remover esses diretórios após a execução, evitando deixar binários de compilação junto aos arquivos-fonte.

## Personalização

Edite ~/.vimrc para ajustar opções, atalhos e regras de indentação. As configurações específicas por linguagem ficam na seção CONFIGURAÇÕES POR TIPO DE ARQUIVO.

O arquivo usa recursos nativos do Vim. Não é necessário instalar plugin manager, executar :PlugInstall ou configurar servidores LSP.

## Solução de problemas

### A configuração apresenta erro ao carregar

A partir da raiz do repositório, faça uma verificação não interativa da configuração:

~~~bash
vim -Nu ./vimrc -n -es -c 'qall!'
~~~

Depois, abra o Vim e execute:

~~~vim
:source ~/.vimrc
:messages
~~~

Confira também a versão e os recursos compilados:

~~~bash
vim --version
~~~

### O atalho ,r informa que uma ferramenta não foi encontrada

Instale a ferramenta correspondente e confirme que ela está no PATH:

~~~bash
command -v python3
command -v javac
command -v java
command -v gcc
command -v g++
command -v git
~~~

Os comandos são exemplos; verifique apenas os executáveis necessários à linguagem utilizada.

### O terminal integrado não abre

Verifique se vim --version mostra +terminal. Algumas distribuições fornecem uma compilação do Vim sem esse recurso.

### Copiar e colar não funciona com a área de transferência do sistema

Verifique se vim --version mostra suporte a clipboard e se existe um provedor instalado no ambiente gráfico/terminal Linux.

### A verificação ortográfica não encontra palavras em português

Instale os arquivos de dicionário do Vim para português e inglês. A configuração ativa spell em arquivos Markdown e de mensagem de commit.

## Filosofia do projeto

Este repositório prioriza simplicidade, transparência e manutenção. A configuração não tenta transformar o Vim em uma IDE dependente de extensões: utiliza os recursos que já fazem parte do editor e deixa compiladores, intérpretes e Git como ferramentas externas do sistema.

Contribuições e sugestões são bem-vindas por meio de issues e pull requests.
