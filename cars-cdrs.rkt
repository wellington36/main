#lang racket

;(1 3 (5 7) 9)
(car (cdr (car (cdr (cdr '(1 3 (5 7) 9))))))
(car (cdaddr '(1 3 (5 7) 9)))

; ((7))
(car (car '((7))))
(caar '((7)))

; (1 (2 (3 (4 (5 (6 7))))))
(cadadr (cadadr (cadadr '(1 (2 (3 (4 (5 (6 7)))))))))

(define (caar x)
  (car (car x)))


