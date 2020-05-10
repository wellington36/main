#lang racket

(define (lst-sect lis a b) ;recebe uma lista e devolve a secção da lista no intervalo das posições a e b
  (define (aux lis p q) (if (> p 0)
                            (aux (cdr lis) (- p 1) q)
                            (if (> q 0)
                                (cons (car lis) (aux (cdr lis) 0 (- q 1)))
                                empty)))
  
  (aux lis a (+ (- b a) 1)))

(define (maxlst lst) ;recebe uma lista de números e devolve o maior elemento
  (if (empty? (cdr lst))
      (car lst)
      (if (> (car lst) (cadr lst))
          (maxlst (cons (car lst) (cddr lst)))
          (maxlst (cdr lst)))))

;;Barreiras são as maiores alturas que estão entre um determinado elemento e o início ou o final da lista.
;;Havendo assim a necessidade de que ambas as barreiras (esquerda e a direita) sejam maiores que o elemento para ocorrer acúmulo de água nele.

(define (after-rain array) ;recebe uma lista e devolve a lista pós-chuva

  (define (barriers x) ;recebe um posição de elemento da array e devolve as barreiras que o cercam
    (cons (maxlst (lst-sect array 0 x)) (maxlst (lst-sect array x (- (length array) 1)))))
  
  (define (short-top x) ;recebe uma posição de elemento na array e devolve a menor das barreiras que o cercam
    (let ([brs (barriers x)])
      (min (car brs) (cdr brs))))

  (define (between-tops? x) ; responde se x está entre barreiras
    (> (short-top x) (list-ref array x)))
  
  (define (put-water x)
    (if (between-tops? x)
        (after-rain (list-set array x (short-top x)))
        (if (< (+ x 1) (length array))
            (put-water (+ x 1))
            array)))
  (put-water 0))

(define (water-amount array) ;DEVOLVE A QUANTIDADE DE ÁGUA ARMAZENADA
  (- (foldr + 0 (after-rain array)) (foldr + 0 array)))

;;(water-amount '(2 3 1 2 4))
;;(water-amount '(4 5 3 7 1 6 3))

(provide maxlst)