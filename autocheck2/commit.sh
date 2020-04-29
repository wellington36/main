#!/bin/bash
#
# Chamar com "./commit.sh lista-X"
#
# Dá commit nos arquivos colocados nos repositórios.

ANS_DIR=$@-answers

cd $ANS_DIR
if [ $? -ne 0 ]
then
    printf "É preciso clonar respostas em $ANS_DIR\n"
    printf "Faça com ./clone.sh $LISTA\n"
    exit 1
fi

for d in $(ls)
do

    cd $d
    # Se não conseguiu entrar na pasta
    if [ $? -ne 0 ]
    then
        continue
    fi
    
    git add README.md checks/
    git commit -m "Coloca resultados"
    git push

    cd ..

done
