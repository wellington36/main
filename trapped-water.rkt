#lang racket

; recebe uma lista e devolve a secção da lista no intervalo das
; posições a e b
(define (lst-sect lis a b) 
  (define (aux lis p q) (if (> p 0)
                            (aux (cdr lis) (- p 1) q)
                            (if (> q 0)
                                (cons (car lis) (aux (cdr lis) 0 (- q 1)))
                                empty)))
  
  (aux lis a (+ (- b a) 1)))

; recebe uma lista de números e devolve o maior elemento
(define (maxlst lst) 
  (if (empty? (cdr lst))
      (car lst)
      (if (> (car lst) (cadr lst))
          (maxlst (cons (car lst) (cddr lst)))
          (maxlst (cdr lst)))))


;; Barreiras são as maiores alturas que estão entre um determinado
;; elemento e o início ou o final da lista.  Havendo assim a
;; necessidade de que ambas as barreiras (esquerda e a direita) sejam
;; maiores que o elemento para ocorrer acúmulo de água nele.

; recebe uma lista e devolve a lista pós-chuva
(define (after-rain array) 

  ; recebe um posição de elemento da array e devolve as barreiras que
  ; o cercam
  (define (barriers x) 
    (cons (maxlst (lst-sect array 0 x))
          (maxlst (lst-sect array x (- (length array) 1)))))

  ; recebe uma posição de elemento na array e devolve a menor das
  ; barreiras que o cercam
  (define (short-top x) 
    (let ([brs (barriers x)])
      (min (car brs) (cdr brs))))

  ; responde se x está entre barreiras
  (define (between-tops? x) 
    (> (short-top x) (list-ref array x)))
  
  (define (put-water x)
    (if (between-tops? x)
        (after-rain (list-set array x (short-top x)))
        (if (< (+ x 1) (length array))
            (put-water (+ x 1))
            array)))
  (put-water 0))

; devolve a quantidade de água armazenada
(define (water-amount array) 
  (- (foldr + 0 (after-rain array)) (foldr + 0 array)))

;; (water-amount '(2 3 1 2 4))
;; (water-amount '(4 5 3 7 1 6 3))

(provide maxlst)
