#!/bin/bash

# ./check.sh lista-X

# Escreve os resultados em lista-X-result.csv

LISTA=$@

ANS_DIR=$LISTA-answers
RESULT_CSV=$(readlink -f $LISTA-result.csv)
CHECK_DIR=$(readlink -f check-$LISTA)

run_check(){

    printf "\`\`\` bash\n" >> README.md
    printf "# ex-$1\n" >> README.md

    RET=$(racket --lib racket -t ex-$1 -r "$CHECK_DIR"/$1 2>&1)
    printf -- "$RET" >> README.md
    score=$(printf -- "$RET" | grep -c \#ok)

    printf "\n# Pontuação: $score/$2\n" >> README.md
    printf "\`\`\`\n\n" >> README.md
    
    printf "$score, " >> "$RESULT_CSV"

}

check_date(){

    DEADLINE=$(date --date="$1" +"%s")
    COMMIT_TIME=$(git log -1 --format="%at")
    score=1

    if [ "$COMMIT_TIME" -gt "$DEADLINE" ]; then
        score=0
        printf "   atrasado\n"
    fi

    printf "\`\`\` bash\n" >> README.md
    printf "# Data do último commit\n" >> README.md
    date -d @$COMMIT_TIME +"%a, %d %B %Y, %T" >> README.md
    printf "# Tempo limite\n" >> README.md
    date -d @$DEADLINE +"%a, %d %B %Y, %T" >> README.md
    printf "# Pontuação: $score/1\n" >> README.md
    printf "\`\`\`\n\n" >> README.md
    
    printf "$score, " >> "$RESULT_CSV"

}

check_files(){

    FILES=$(ls | wc -l)
    NO_FILES=$1
    score=1
    if [ "$FILES" -ne $NO_FILES ]; then
        score=0
        printf "   $FILES files\n"
    fi
    
    printf "\`\`\` bash\n" >> README.md
    printf "# Número de arquivos\n" >> README.md
    printf "$FILES\n" >> README.md
    printf "# Esperado\n" >> README.md
    printf "$NO_FILES\n" >> README.md
    printf "# Pontuação: $score/1\n" >> README.md
    printf "\`\`\`\n\n" >> README.md
    
    printf "$score, " >> "$RESULT_CSV"

}

cd $ANS_DIR
if [ $? -ne 0 ]
then
    printf "É preciso clonar respostas em $ANS_DIR\n"
    printf "Faça com ./clone.sh $LISTA\n"
    exit 1
fi

rm -f "$RESULT_CSV"

# Cabeçalho do CSV
printf "aluno, " >> "$RESULT_CSV"
for ex in $(ls "$CHECK_DIR")
do
    printf "ex-$ex, " >> "$RESULT_CSV"
done
printf "prazo, repositório,\n" >> "$RESULT_CSV"

# Loop para cada aluno
for aluno in $(ls)
do

    cd $aluno
    if [ $? -ne 0 ]
    then
        continue
    fi

    printf "$aluno\n"
    
    rm -f README.md
    printf "# Resultados\n\n" >> README.md
    
    printf "$aluno, " >> "$RESULT_CSV"
    
    # TODO - fazer ficar genérico para qualquer lista
    run_check 1.19.rkt 4
    run_check 1.27.rkt 4
    run_check 1.30.rkt 1
    run_check 1.31.rkt 2

    check_date "03/30/2020 01:00:00"
    check_files 6
    
    printf "\n" >> "$RESULT_CSV"

    cd ..

done
