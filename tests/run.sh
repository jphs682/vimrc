#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
VIM_BIN=${VIM:-vim}

if ! command -v "$VIM_BIN" >/dev/null 2>&1; then
    echo "Erro: Vim não encontrado. Defina VIM=/caminho/para/vim." >&2
    exit 127
fi

"$VIM_BIN" -Nu "$ROOT/vimrc" --noplugin -n -es -S "$ROOT/tests/check-vimrc.vim"
echo "Testes básicos do vimrc: OK"
