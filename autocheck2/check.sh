#!/bin/bash

LISTA=$@

ANS_DIR=$LISTA-answers
ROOT_DIR=$(pwd)
RESULT_CSV="$ROOT_DIR/$LISTA-result.csv"

cd "$ANS_DIR"
if [ $? -ne 0 ]
then
    printf "É preciso clonar respostas em $ANS_DIR\n"
    printf "Faça com ./clone.sh $LISTA\n"
    exit 1
fi

rm -f "$RESULT_CSV"

# Cabeçalho do CSV
printf "aluno, pontuação\n" >> "$RESULT_CSV"

# Loop para cada aluno
for aluno in $(ls)
do

    cd $aluno

    # Se não conseguiu entrar na pasta
    if [ $? -ne 0 ]
    then
        continue
    fi

    printf "$aluno \t"
    
    # Copia os arquivos de checagem
    rm -rf checks
    mkdir -p checks
    cp -f "$ROOT_DIR/gui.rkt" checks/
    cp -f "$ROOT_DIR/check-grades.rkt" checks/
    cp -f "$ROOT_DIR/suite-$LISTA.rkt" checks/suite.rkt
    
    # Roda o teste do Racket
    TESTS=$(racket checks/check-grades.rkt 2>&1)
    
    # Se o teste não rodar
    if [ $? -ne 0 ]
    then
        GRADE_FLOAT="0"
        printf "ERR\n"
    else
        # Pega a nota que está na última linha
        GRADE=$(printf "$TESTS" | tail -n1)
        GRADE_FLOAT=$(bc <<< 'scale=2; '$GRADE'')
        printf "$GRADE\n"
    fi
    
    # Escreve o resultado no README.md
    rm -f README.md
    printf "# Resultados\n\n" >> README.md
    printf "\`\`\`\n" >> README.md
    printf "$TESTS" >> README.md
    printf "\n\`\`\`\n" >> README.md
    
    # Escreve o resultado no CSV
    printf "$aluno, $GRADE_FLOAT\n" >> "$RESULT_CSV"
    
    cd ..

done
