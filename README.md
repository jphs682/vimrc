# vimrc
Minhas Configurações do Vim
.vim/vimrc
Ainda esta em desenvolvimeto

### 🛠️ Correção Rápida (opcional):
  - Se quiser usar source no terminal sem erros, transforme seu vimrc em um script compatível com shell:
``` bash
# Este é um WRAPPER para carregar o vimrc no Vim
vim -u ~/.config/vimrc/vimrc "$@"
```
  - Salve como vimrc-loader.sh e execute com:
``` bash
chmod +x vimrc-loader.sh
./vimrc-loader.sh
```

### 🔧 Vimrc Corrigido (só ajustes de compatibilidade):
``` bash
" ======================================================================
" CONFIGURAÇÕES BÁSICAS
" ======================================================================

" Verifica suporte a cores verdadeiras
if has('termguicolors')
    set termguicolors
else
    set t_Co=256
endif

" Ativa recursos essenciais
filetype plugin indent on
syntax on
set title
set backspace=indent,eol,start
set noerrorbells
set confirm
set hidden
set splitbelow
set splitright
set fillchars=vert:│,fold:-,eob:~,lastline:@
set path=.,**
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

" Formatação de texto
set nowrap
set linebreak
set nolist
set listchars=tab:›-,space:·,trail:◀,eol:↲

" Números e cursor
set number
set relativenumber
set scrolloff=2
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

" Busca
set ignorecase
set smartcase
set incsearch
set hls
let @/ = ""

" Autocompletar
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c
set spelllang=pt_br,en

" Interface
set wildmenu
set wildmode=longest,full
set wildoptions=pum
colorscheme industry
set noshowmode
set laststatus=2

" ======================================================================
" BARRA DE STATUS PERSONALIZADA
" ======================================================================
function! LoadStatusLine()
    let g:left_sep = '|'
    let g:right_sep = '|'

    let g:currentmode = {
        \ 'n': 'Normal',
        \ 'v': 'Visual',
        \ 'i': 'Insert',
        \ 'R': 'Replace',
        \ 'c': 'Command',
        \ 't': 'Terminal'
        \}

    set statusline=\ %{toupper(g:currentmode[mode()])}
    set statusline+=\ %{left_sep}
    set statusline+=\ %n
    set statusline+=\ %{left_sep}
    set statusline+=\ %f%m\ %y
    set statusline+=\ %{left_sep}
    set statusline+=\ %{&ff}\ %{&fenc!=''?&fenc:&enc}
    set statusline+=\ %{left_sep}
    set statusline+=\ %=
    set statusline+=\ %{right_sep}
    set statusline+=\ %l/%L,%v
    set statusline+=\ %{right_sep}
    set statusline+=\ %P\ 
    set statusline+=\ %{right_sep}
    set statusline+=\ %{strftime('%H:%M')}
endfunction

call LoadStatusLine()

" Destaques visuais
hi Normal guibg=NONE ctermbg=NONE
hi CursorLine guibg=#202130
hi Comment cterm=italic gui=italic
hi VertSplit ctermbg=NONE guibg=NONE ctermfg=7 guifg=#c1c2d0
hi TabLine guifg=#9192a0 guibg=#303140 gui=none
hi TabLineSel guifg=#a1a2b0 guibg=#101120 gui=bold
hi TabLineFill guifg=#9192a0 guibg=#303140 gui=none
hi Visual guifg=NONE guibg=#303140
```
```markdown

# Configuração Avançada de Vim

Esta é uma configuração avançada do Vim transformando-o em um IDE completo com suporte a autocompletar inteligente, linting, integração com Git e muito mais.

## Recursos Principais

- 🚀 Autocompletar inteligente com **CoC.nvim** (baseado em Language Server Protocol)

- 🎨 Tema visual elegante com **Gruvbox** e barra de status com **Airline**

- 🌳 Navegação em árvore de arquivos com **NERDTree**

- 🔍 Busca rápida de arquivos com **FZF**

- 🔧 Linting assíncrono com **ALE**

- 💻 Integração completa com Git através de **vim-fugitive** e **vim-gitgutter**

- ⚡ E muitas outras ferramentas de produtividade

## Pré-requisitos

- Vim (versão 8.2 ou superior) ou Neovim

- Node.js (para CoC.nvim)

- Python 3 (para alguns plugins)

- Git

## Instalação

### 1. Copie o arquivo de configuração

Clone este repositório ou copie o arquivo `.vimrc` para seu diretório home:

```bash

git clone https://github.com/seu-usuario/seu-repositorio.git ~/.vim-config

ln -s ~/.vim-config/.vimrc ~/.vimrc

```

### 2. Instale os plugins

Abra o Vim e execute:

```vim

:PlugInstall

```

### 3. Instale as dependências

#### Node.js (requerido para CoC)

```bash

# Fedora

sudo dnf install nodejs npm

```

#### Python

```bash

sudo dnf install python3 python3-pip

```

### 4. Instale os Language Servers (opcional mas recomendado)

Instale os servidores LSP para as linguagens que você usa:

```bash

# JavaScript/TypeScript

npm install -g typescript typescript-language-server

# Python

pip3 install pyright

# HTML/CSS/JSON

npm install -g vscode-langservers-extracted

# Outras linguagens (verifique a documentação do CoC)

```

## Configuração Pós-Instalação

### Ícones (opcional)

Para ter ícones no NERDTree e na barra de status:

1. Instale uma fonte powerline patched:

```bash

sudo dnf install powerline-fonts

```

2. Configure seu terminal para usar uma fonte como "DejaVu Sans Mono for Powerline"

### Configurações Específicas

Edite o arquivo `.vimrc` para:

- Adicionar/remover plugins

- Ajustar atalhos

- Configurar language servers específicos

## Dicas de Uso

### Atalhos Essenciais

| Atalho             | Descrição                           |

|--------------------|-------------------------------------|

| `<C-p>`            | Buscar arquivos (FZF)               |

| `<C-n>`            | Alternar NERDTree                   |

| `,nf`              | Encontrar arquivo atual no NERDTree |

| `,b`               | Listar buffers abertos              |

| `gd`               | Ir para definição                   |

| `gr`               | Ver referências                     |

| `,rn`              | Renomear símbolo                    |

| `,f`               | Formatar código                     |

| `<leader>h`        | Histórico de arquivos               |

| `<F5>`             | Alternar Undotree (histórico)       |

| `,tt`              | Abrir terminal                      |

### Comandos Úteis

| Comando            | Descrição                          |

|--------------------|------------------------------------|

| `:CocList`         | Listar informações do CoC          |

| `:CocRestart`      | Reiniciar CoC                      |

| `:Git`             | Abrir interface do Git             |

| `:UndotreeToggle`  | Mostrar histórico de alterações    |

| `:ALEDetail`       | Mostrar detalhes de erros (linting)|

### Navegação

- Use `Ctrl + hjkl` para navegar entre janelas

- Use `Ctrl + l` e `Ctrl + h` para navegar entre buffers

- Use `Ctrl + setas` para redimensionar janelas

## Personalização

Para adicionar novos plugins:

1. Adicione no bloco `call plug#begin()`:

```vim

Plug 'autor/plugin'

```

2. Recarregue o vimrc (`:source ~/.vimrc`)

3. Execute `:PlugInstall`

Para configurar language servers adicionais, edite a lista em:

```vim

let g:coc_global_extensions = [ ... ]

```

## Solução de Problemas

### Erros ao abrir o Vim

- Verifique se todos os plugins foram instalados com `:PlugStatus`

- Atualize os plugins com `:PlugUpdate`

### Problemas com CoC

- Verifique se o Node.js está instalado: `node --version`

- Instale as dependências do projeto quando necessário (ex: `npm install` para projetos JS)

### Ícones não aparecem

- Instale uma fonte powerline e configure seu terminal

## Contribuição

Sinta-se à vontade para abrir issues e pull requests com melhorias!

```

Este README está completo com:

1. Título e descrição

2. Lista de recursos

3. Pré-requisitos

4. Passos de instalação detalhados

5. Dicas de uso com tabelas de atalhos

6. Seção de personalização

7. Solução de problemas

8. Instruções para contribuição

