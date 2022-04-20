#!/bin/bash

main() {

    modulo=false; archivo= ; clase=0
    while getopts ":a:c:t:mh" argv; do
        case "${argv}" in
            a) 
                if [[ $OPTARG == *".hs" ]]
                then archivo=$OPTARG
                else
                    printf "\033[38;5;210mEl nombe del archivo ingresado es invalido\033[0m\n"
                    echo "Reingresa el nombre del archivo, incluyendo su extension (.hs)"
                    while [[ $archivo != *".hs" ]]; do read -p "archivo: " archivo ; done
                fi ;;
            c)
                if [[ $OPTARG -ge 1 && $OPTARG -le 8 ]]
                then clase=$OPTARG
                else
                    printf "\033[38;5;210mEl numero de clase es invalido!\033[0m\n"
                    echo "Reingresa numero de clase (entre 1 y 10)"
                    while [[ $clase -lt 1 || $clase -gt 10 ]]; do read -p "clase: " clase ; done
                fi ;;
            m) modulo=true ;;
            t) tp $OPTARG ;;
            h) hmsg ;;
            *) errarg ;;
        esac
    done

    clase="clase$clase-test.hs"

    $modulo && echo "import $(echo ${archivo^} | cut -d'.' -f 1)" > tmp.hs && cat "tests/"$clase >> tmp.hs && run m && exit 0
    cp $archivo tmp.hs && cat $clase >> tmp.hs && run; }

run() { ghc --make tmp.hs && ./tmp && rm -f tmp*; if [ $# ]; then rm -f *.o *.hi; fi; }

# mensaje de ayuda
hmsg() { printf "
    \033[0;30;103m Test de funciones del Taller de Haskell para Algebra I \033[0m\n
    \033[38;5;11mUso: ./tester.sh -a archivo.hs -c n [-m]\033[0m\n
    \033[0;93m-a\033[0m: el nombre del archivo de haskell (.hs) el cual se quiere verificar.
    \033[0;93m-c\033[0m: el numero de la clase a la cual el archivo corresponde.
    \033[0;93m-m\033[0m: Si el archivo a testear es un modulo, es necesario usar -m.

    Ejemplo: \033[0;93m./tester.ps1 -a Clase4.hs -c 4 \033[0m\n
    Si las funciones estan contenidas en un modulo: \033[0;93m./tester.ps1 -a Clase4.hs -c 4 -m \033[0m

    Para mas informacion: https://github.com/FacundoLema/taller-haskell\n\n"
    exit 0; }

errarg() { printf "\n    \033[38;5;210mEl argumento -$OPTARG no es un argumento valido.\033[0m\n"; hmsg; exit 1; }

tp () { cp "tp"$1".hs" tmp.hs && cat "tests/tp"$1"-test.hs" >> tmp.hs && run; exit 0; }

main $@