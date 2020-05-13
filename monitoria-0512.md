# Monitoria 01/05

Foram tiradas dúvidas e resolvido o item a)
do exercício 2.58.


Foi discutido o problema 23 da [lista de problemas da Unicamp](https://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html)
e foi visto que é possível definir um valor padrão para o argumento de uma função no Racket:

```racket
(define (exponential (expoent 1))
	(exp expoent))

(exponential)   ; Valor será e^1
(exponential 2) ; Valor será e^2
```

# Arquivos

- ex-2.58-m.rkt
- remove-at-m.rkt

