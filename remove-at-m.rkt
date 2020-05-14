#lang racket

#|

The selected items shall be returned in a list. Example: 

* (rnd-select '(a b c d e f g h) 3)
(E D A)

Hint: Use the built-in random number generator and the result of
problem P20.

|#


;; P20: Remove the K'th element from a list.

(define (remove-at alist p)
  (define (aux alist before n)
    (if (equal? n 0)
        (car alist)))
  (aux alist empty 0))

(define (rnd-select alist num)
  
  (let ((len (length alist)))
    ))

; A função remove-at recebe uma lista e um valor n
; e retorna a lista sem o n-ézimo elemento

(define (remove-at org-list pos)
  (define (iter list i)
    (if (equal? pos i)
        (cdr list)
        (cons (car list) (iter (cdr list) (+ i 1)))))
  (iter org-list 1))

; Essa função pode ser escrita sem definir uma outra função interna
; Para isso basta criar um novo argumento (ini) que tem valor padrão 1
; Assim, se a função for chamada sem esse argumento, seu valor será 1

(define (remove-at2 org-list pos (ini 1))
  (if (equal? pos ini)
      (cdr org-list)
      (cons (car org-list) (remove-at2 (cdr org-list) pos (+ ini 1)))))

;

(remove-at '(1 2 3 4 5 6 7 8) 4)
(remove-at2 '(1 2 3 4 5 6 7 8) 4)
