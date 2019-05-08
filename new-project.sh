#!/bin/bash

# Colors
corPadrao="\033[0m"
preto="\033[0;30m"
vermelho="\033[0;31m"
verde="\033[0;32m"
marrom="\033[0;33m"
azul="\033[0;34m"
purple="\033[0;35m"
cyan="\033[0;36m"
cinzaClaro="\033[0;37m"
pretoCinza="\033[1;30m"
vermelhoClaro="\033[1;31m"
verdeClaro="\033[1;32m"
amarelo="\033[1;33m"
azulClaro="\033[1;34m"
purpleClaro="\033[1;35m"
cyanClaro="\033[1;36m"
branco="\033[1;37m"
#################################################################################

Makefile=https://gist.githubusercontent.com/Romario17/ed73ca48f38c8cf08a6c54bfc97bd498/raw/f270949eea6522ef7abeca7345e8ede816232b82/makefile
Main_CPP=https://gist.githubusercontent.com/Romario17/b084f2a6655430fd003b23e0948e65b1/raw/6471c11cabb2937c7416911abb0a443e824ade59/main.cpp
Colors_hpp=https://gist.githubusercontent.com/Romario17/e2a7ad6006cc605d4578f7660009bcb9/raw/7a09f73772f810525a2b331dbd3f9fbb1f8f0f3a/colors.hpp

src=src
main=main.cpp

#################################################################################
function create-directories ()
{
    echo -e "$azulClaro\tCriando Diretórios ...$corPadrao\n"
    mkdir $1 && echo -e "$branco\t\t$1 -->$verdeClaro OK$corPadrao"
    mkdir $1/debug && echo -e "$branco\t\t$1/debug -->$verdeClaro OK$corPadrao"
    mkdir $1/include && echo -e "$branco\t\t$1/include -->$verdeClaro OK$corPadrao"
    mkdir $1/obj && echo -e "$branco\t\t$1/obj -->$verdeClaro OK$corPadrao"
    mkdir $1/$src && echo -e "$branco\t\t$1/$src -->$verdeClaro OK$corPadrao"
}

function create-file-codes ()
{
    echo -e "\n$azulClaro\tBaixando arquivos do projeto ...$corPadrao\n"

    cd $1/$src && wget $Main_CPP -q
    cd .. && wget $Makefile -q

    if [ -e "$src/$main" ]
    then
        echo -e "$branco\t\t$1/$src/$main -->$verdeClaro OK$corPadrao"
    else
        echo -e "$branco\t\t$1/$src/$main -->$vermelhoClaro NO$corPadrao"
    fi

    if [ -e "makefile" ]
    then
        echo -e "$branco\t\t$1/makefile -->$verdeClaro OK$corPadrao"
    else
        echo -e "$branco\t\t$1/makefile -->$vermelhoClaro NO$corPadrao"
    fi

    cd ..
}

function create-project ()
{
    create-directories $1
    create-file-codes $1
}
#################################################################################

# verifica se o número de argumentos é menor que 1
if [ $# -lt 1 ]
then
    echo -e "$vermelhoClaro Nenhum argumento foi passado! $corPadrao"
    echo -e " ----> Ex:$verdeClaro bash$corPadrao new-project.sh$branco my-project$corPadrao"
    exit 1
fi

# verifica se há um diretório com o mesmo nome do argumento passado
if [ -e $1 ]
then
    echo -e "$vermelhoClaro Diretório $branco $1 $vermelhoClaro já existe! $corPadrao"
    exit 1
else
    echo -e "$amarelo\nCriando Projeto ... $corPadrao\n"
    create-project $1
    echo -e "$verdeClaro\nProcesso terminado!!!$corPadrao\n"
fi