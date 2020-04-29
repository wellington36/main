#lang racket

;; desvantagem: se fn retornar false para alguma entrada da lista, a iteração é interrompida.

(define (for-each fn lst)
  (if (empty? lst)
      #t
      (and (fn (car lst))
           (for-each fn (cdr lst)))))

(define (for-each fn lst)
  (if (empty? lst)
      #t
      (begin (fn (car lst))
             (for-each fn (cdr lst)))))


(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))



         