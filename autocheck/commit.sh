#!/bin/bash
#
# Chamar com "./commit.sh lista-X"
#
# Dá commit nos arquivos README.md
# colocados nos repositórios.

ANS_DIR=$@-answers

cd $ANS_DIR

for d in $(ls)
do

    cd $d
    git add README.md
    git commit -m "Coloca resultados"
    git push
    cd ..

done
