#!/bin/bash

modulo=false; archivo= ; clase=0
while getopts ":a:c:mh" argv; do
    case "${argv}" in
        a) 
            if [[ $OPTARG == *".hs" ]]
            then archivo=$OPTARG
            else
                printf "\n\033[38;5;210mEl nombe del archivo ingresado es invalido!\033[0m\n"
                echo "Por favor, reingrese el nombre del archivo, incluyendo su extension (.hs)"
                
                while [[ $archivo != *".hs" ]]
                do 
                    read -p "archivo: " archivo
                done
            fi ;;
        c)
            if [[ $OPTARG -ge 1 && $OPTARG -le 8 ]]
            then clase=$OPTARG
            else
                printf "\n\033[38;5;210mEl numero de clase es invalido!\033[0m\n"
                echo "Por favor, reingrese numero de clase (entre 1 y 8)"
                
                while [[ $clase -lt 1 || $clase -gt 8 ]]
                do 
                    read -p "clase: " clase
                done
            fi ;;
        m) modulo=true ;;
        h)
            printf "\
    \n\033[0;30;103m Test de funciones del Taller de Haskell para Algebra I \033[0m\n
    \033[38;5;11mUso: ./tester.sh archivo.hs n [-m]\033[0m\n
    \033[4;93mArgumentos\033[0;93m:\033[0m tester.ps1 toma dos argumentos obligatorios, 
    -archivo (-a) y -clase (-c).

    \033[0;93m-archivo\033[0m: el nombre del archivo de haskell (.hs) el cual se quiere verificar,
    incluyendo su extension.

    \033[0;93m-clase\033[0m: el numero de la clase a la cual el archivo corresponde. Es necesario
    para saber que funciones evaluar. Este argumento es de tipo [Int].

    \033[4;93mFlags\033[0;93m\033[0m: tester.ps1 tiene una flag, -module (-m). Si el archivo a testear es
    un modulo (es decir, si el archivo contiene 'module ModuleName where'), es
    es necesario usar la flag -modulo (-m).

    Ejemplo: dado un archivo Clase4.hs, correspondiente a los ejercicios de la
    clase 4, el cual contiene un modulo llamado Clase4 con todas las funciones,
    deberia usarse:

    \033[0;93m\t./tester.ps1 -archivo Clase4.hs -clase 4 -m \033[0m

    Si las funciones de Clase4.hs estan contenidas en un modulo, entonces:

    \033[0;93m\t./tester.ps1 -archivo Clase4.hs -clase -m \033[0m

    Para ver este mensaje de nuevo: ./tester.sh -h

    Para mas informacion: https://github.com/FacundoLema/taller-haskell\n\n"
            exit 0
            ;;
        *)
            printf "\n\033[38;5;210mEl argumento -$OPTARG no es un argumento valido.\033[0m\n"
            printf "\033[38;5;11mUso: ./tester.sh archivo.hs n [-m]\033[0m\n"
            printf "Mas informacion: ./tester -h\n\n"
            exit 1
            ;;
    esac
done

clase="clase$clase-test.hs"

run() { ghc --make tmp.hs && ./tmp && rm -f tmp*; if [ $# ]; then rm -f *.o *.hi; fi; }

$modulo && echo "import $(echo ${archivo^} | cut -d'.' -f 1)" > tmp.hs && cat $clase >> tmp.hs && run m && exit 0

cp $archivo tmp.hs && cat $clase >> tmp.hs && run