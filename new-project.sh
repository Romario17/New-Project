#!/bin/bash

################### Constants variables ######################
# colors
readonly DEFAULT="\033[0m"
readonly BLACK="\033[0;30m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly BLUE="\033[0;34m"
readonly MAGENTA="\033[0;35m"
readonly CYAN="\033[0;36m"
readonly LIGHT_RED="\033[1;31m"
readonly LIGHT_GREEN="\033[1;32m"
readonly YELLOW="\033[1;33m"
readonly LIGHT_BLUE="\033[1;34m"
readonly LIGHT_MAGENTA="\033[1;35m"
readonly LIGHT_CYAN="\033[1;36m"
readonly WHITE="\033[1;37m"

declare -A ERROR_MESSAGES
ERROR_MESSAGES["create-directories"]=$LIGHT_RED"Error: Falha na criação da estrutura de diretório!!!"$DEFAULT
ERROR_MESSAGES["create-file-codes"]=$YELLOW"Warning: Falha ao baixar um\vários arquivo(s) de código!!!"$DEFAULT
readonly ERROR_MESSAGES

declare -A URL_TABLE
URL_TABLE["makefile"]=https://gist.githubusercontent.com/Romario17/ed73ca48f38c8cf08a6c54bfc97bd498/raw/14409ecc76e58eb4644178bea1a33a4771a77310/makefile
URL_TABLE["main-cpp"]=https://gist.githubusercontent.com/Romario17/2254db67239976af01570134bd65fe50/raw/4ae82b34c23161176f5c5d4927de1c95f5e1546a/main.cpp
URL_TABLE["color-hpp"]=https://gist.githubusercontent.com/Romario17/e2a7ad6006cc605d4578f7660009bcb9/raw/7a09f73772f810525a2b331dbd3f9fbb1f8f0f3a/colors.hpp
readonly URL_TABLE

readonly MAIN=main.cpp

# boolean
readonly TRUE=0
readonly FALSE=1
#################################################################################

function create-directories ()
{
    local readonly DIRS=($1 $1/debug $1/include $1/obj $1/src)
    
    echo -e "$LIGHT_BLUE\tCriando Diretórios ...$DEFAULT\n"
    
    for((i=0;i<${#DIRS[@]};i++))
    do
        if mkdir ${DIRS[$i]} 2>/dev/null
        then
            echo -e "$WHITE\t\t${DIRS[$i]} -->$LIGHT_GREEN OK$DEFAULT"
        else
            echo -e "$WHITE\t\t${DIRS[$i]} -->$LIGHT_RED NO$DEFAULT"
        fi
    done
    
    if [ -e $1 ]
    then
        return $TRUE
    else
        return $FALSE
    fi
}

function create-file-codes ()
{
    echo -e "\n$LIGHT_BLUE\tBaixando arquivos do projeto ...$DEFAULT\n"
    
    cd src && wget ${URL_TABLE["main-cpp"]} -q
    
    if [ -e "$MAIN" ]
    then
        echo -e "$WHITE\t\t$1/src/$MAIN -->$LIGHT_GREEN OK$DEFAULT"
    else
        echo -e "$WHITE\t\t$1/src/$MAIN -->$LIGHT_RED NO$DEFAULT"
    fi
    
    cd .. && wget ${URL_TABLE["makefile"]} -q
    
    if [ -e "makefile" ]
    then
        echo -e "$WHITE\t\t$1/makefile -->$LIGHT_GREEN OK$DEFAULT"
    else
        echo -e "$WHITE\t\t$1/makefile -->$LIGHT_RED NO$DEFAULT"
    fi

    if [ -e "makefile" ]
    then
        if [ -e "src/$MAIN" ]
        then
            return $TRUE
        else
            return $FALSE
        fi
    else
        return $FALSE
    fi
}

function create-project ()
{    
    create-directories $1
    
    case $? in
        $TRUE)
            cd $1
            create-file-codes $1
            return $?
        ;;
        $FALSE)
            return $FALSE
        ;;
    esac
}
#################################################################################

function main ()
{
    # verifica se o número de argumentos é menor que 1
    if [ $# -lt 1 ]
    then
        echo -e "$LIGHT_RED Nenhum argumento foi passado! $DEFAULT"
        echo -e " ----> Ex:$LIGHT_GREEN bash$DEFAULT new-project.sh$WHITE my-project$DEFAULT"
        exit 1
    fi
    
    # verifica se há um diretório com o mesmo nome do argumento passado
    if [ -e $1 ]
    then
        echo -e "$LIGHT_RED Diretório $WHITE $1 $LIGHT_RED já existe! $DEFAULT"
        exit 1
    else
        echo -e "$YELLOW\nCriando Projeto ... $DEFAULT\n"
        
        create-project $1
        
        if [ $? -eq $TRUE ]
        then
            echo -e "$LIGHT_GREEN\nProjeto criado com Sucesso!!!$DEFAULT\n"
        else
            echo -e "$LIGHT_RED\nFalha na criação do Projeto!!!$DEFAULT\n"
        fi
    fi
}

main $*