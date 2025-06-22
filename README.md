# vimrc
Minhas Configurações do Vim
.vim/vimrc
Ainda esta em desenvolvimeto

🛠️ Correção Rápida (opcional):
Se quiser usar source no terminal sem erros, transforme seu vimrc em um script compatível com shell:

bash
#!/bin/bash
# Este é um WRAPPER para carregar o vimrc no Vim
vim -u ~/.config/vimrc/vimrc "$@"
Salve como vimrc-loader.sh e execute com:

bash
chmod +x vimrc-loader.sh
./vimrc-loader.sh
