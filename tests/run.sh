#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
VIM_BIN=${VIM:-vim}
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT HUP INT TERM

if ! command -v "$VIM_BIN" >/dev/null 2>&1; then
    echo "Erro: Vim não encontrado. Defina VIM=/caminho/para/vim." >&2
    exit 127
fi

run_vim_test() {
    source_file=$1
    "$VIM_BIN" -Nu "$ROOT/vimrc" --noplugin -n -es "$source_file" -S "$ROOT/tests/run-language.vim"
    echo "OK: $(basename "$source_file")"
}

echo "== Testes de configuração e recursos =="
"$VIM_BIN" -Nu "$ROOT/vimrc" --noplugin -n -es -S "$ROOT/tests/check-vimrc.vim"
echo "OK: configuração, comandos, numeração, comentários, modelos e JSON"

echo "== Testes de compilação e execução =="
if command -v python3 >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.py" <<'PY'
print("python-ok")
PY
    run_vim_test "$TMP_DIR/teste.py"
else
    echo "SKIP: python3 não instalado"
fi

if command -v node >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.js" <<'JS'
console.log("javascript-ok");
JS
    run_vim_test "$TMP_DIR/teste.js"
else
    echo "SKIP: node não instalado"
fi

if command -v ts-node >/dev/null 2>&1 && ts-node --version >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.ts" <<'TS'
const message: string = "typescript-ok";
console.log(message);
TS
    run_vim_test "$TMP_DIR/teste.ts"
else
    echo "SKIP: ts-node não instalado"
fi

if command -v gcc >/dev/null 2>&1; then
    mkdir -p "$TMP_DIR/dir com espaços; marcador"
    cat > "$TMP_DIR/dir com espaços; marcador/teste.c" <<'C'
#include <stdio.h>
int main(void) { puts("c-ok"); return 0; }
C
    run_vim_test "$TMP_DIR/dir com espaços; marcador/teste.c"
else
    echo "SKIP: gcc não instalado"
fi

if command -v g++ >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.cpp" <<'CPP'
#include <iostream>
int main() { std::cout << "cpp-ok" << std::endl; return 0; }
CPP
    run_vim_test "$TMP_DIR/teste.cpp"
else
    echo "SKIP: g++ não instalado"
fi

if command -v rustc >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.rs" <<'RS'
fn main() { println!("rust-ok"); }
RS
    run_vim_test "$TMP_DIR/teste.rs"
else
    echo "SKIP: rustc não instalado"
fi

if command -v go >/dev/null 2>&1; then
    cat > "$TMP_DIR/teste.go" <<'GO'
package main
import "fmt"
func main() { fmt.Println("go-ok") }
GO
    run_vim_test "$TMP_DIR/teste.go"
else
    echo "SKIP: go não instalado"
fi

if command -v javac >/dev/null 2>&1 && command -v java >/dev/null 2>&1; then
    mkdir -p "$TMP_DIR/java"
    cat > "$TMP_DIR/java/Main.java" <<'JAVA'
/*
 * Cabeçalho de exemplo.
 * package comentario.invalido;
 */
package demo;
public class Main {
    public static void main(String[] args) {
        System.out.println(Helper.message());
    }
}
JAVA
    cat > "$TMP_DIR/java/Helper.java" <<'JAVA'
package demo;
public class Helper {
    public static String message() { return "java-ok"; }
}
JAVA
    run_vim_test "$TMP_DIR/java/Main.java"
else
    echo "SKIP: JDK (javac/java) não instalado"
fi

echo "Todos os testes disponíveis foram concluídos."
