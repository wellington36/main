
# Autockeck

Scripts para fazer correção automática de repositórios do GitHub Classroom.

## Clonando repositórios

Para baixar os repositórios da lista-n, execute o script `./clone.sh lista-n`.
Ele vai usar a lista de alunos no arquivo `alunos` para baixar os repositórios.
Ao terminar a execução, os repositórios vão estar na pasta `lista-n-answers`. 
Será gerado um arquivo `clone-lista-n.log`, mostrando para quais repositórios foi
possível fazer a clonagem. O arquivo usa o protocolo SSH para fazer a clonagem,
é preciso ter a chave registrada no GitHub.

## Test suite da lista

Na mesma pasta do script deve conter um arquivo `suite-lista-n.rkt` que define
um test-suite do rackunit para fazer os testes dos exercícios. Ele deve fazer
require dos arquivos do exercício com `(require "../ex-n.rkt")`, os `..` são
porque o test-suite ficará na pasta `checks` do repositório do aluno. O arquivo
deve fazer provide do test-suite com `(provide suite)`.

## Arquivos racket de checagem

O arquivo `check-grades.rkt` vai usar o test-suite para fazer a soma dos acertos
de cada aluno. Ele usa a função `foldts-test-suite` do rackunit para somar e 
printar os acertos de cada aluno. A nota está definida com um `(cons n m)`, que
significa n acertos de m questões. O arquivo `gui.rkt` usa o `test/gui` do rackunit
para mostrar uma interface gráfica com as questões corretas.

Se não foi feito o provide nos exercícios, é possível ainda fazer o require das
funções com `(require/expose "ex-n.rkt" (fun1 fun2 fun3))`.

## Rodando a checagem automática

Depois de feito o clone e criado o test-suite da lista-n, para realizar a checagem
é preciso executar o script `./check.sh lista-n`. O script roda para cada pasta
em `lista-n-answers`. Ao rodá-lo ele irá copiar os arquivos `check-grades.rkt`
`gui.rkt` `suite-lista-n.rkt` para a pasta `checks` em cada repositório. Em seguida
roda o arquivo `check-grades.rkt`, que roda os testes. A saída dessa execução será
colocada no `README.md` do repositório. Na última linha estará a nota do aluno.
É gerado um csv com a pontuação de cada aluno.

## Mandando as notas para os repositórios

Para mandar as respostas para o GitHub, é preciso rodar o script `./commit.sh lista-n`.
Ele fará com commit com a pasta `checks/` e o arquivo `README.md` e em seguida fará
push de cada repositório para o GitHub.