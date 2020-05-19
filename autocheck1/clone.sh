#!/bin/bash
#
# Chamar com "./clone.sh lista-X"
#
# Clona os repositórios "emap-ic-2020-1/lista-X-aluno"
# usando os alunos do arquivo "alunos" para a pasta "lista-X-answers".

ANS_DIR=$@-answers
LOG_FILE=clone-$@.log

mkdir -p $ANS_DIR
rm -f $LOG_FILE

for i in $(cat alunos)
do

    REPO=$@-$i
    printf "Cloning $REPO\n"

    printf "#### $i\n" >> $LOG_FILE

    rm -rf $ANS_DIR/$i
    git clone git@github.com:emap-ic-2020-1/$REPO.git $ANS_DIR/$i 2>> $LOG_FILE

    printf "#### $?\n\n" >> $LOG_FILE

done
