#lang sicp

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)


(define count-pairs
  (let ((hist '()))
    (lambda (x)
      (cond ((not (pair? x)) 0)
            ((memq x hist)   0)
            (else (set! hist (cons x hist))
                  (+ (count-pairs (car x))
                     (count-pairs (cdr x))
                     1))))))


(count-pairs (list 1 2 3))

(define y1 (list 1))
(define y2 (cons 1 y1))
(define z1 (cons y1 y2))
(count-pairs z1)

(define y3 (cons y1 y1))
(define z2 (cons y3 y3))
(count-pairs z2)

(define z3 (make-cycle (list 'a 'b 'c)))
(count-pairs z3)


;; https://wizardbook.wordpress.com/2010/12/15/exercise-3-17/
(display "testes originais:")

(define l31 (list 'a 'b 'c))
(define l41 (list 'b 'c))
(define l42 (list 'a))
(set-car! l41 l42)
(set-car! (cdr l41) l42)
 
(define l71 (list 'c))
(define l72 (list 'b))
(define l73 (list 'a))
(set-car! l72 l73)
(set-cdr! l72 l73)
(set-car! l71 l72)
(set-cdr! l71 l72)
 
(define linf (list 'a 'b 'c))
(set-cdr! (cdr (cdr linf)) linf)
 
(count-pairs l31)
(count-pairs l41)
(count-pairs l71)
(count-pairs linf)
