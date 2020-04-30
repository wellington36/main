#lang racket


(define (horner-eval x coefficient-sequence)
  (foldr (lambda (this-coeff higher-terms)
           (+ (* x higher-terms) this-coeff))
         0
         coefficient-sequence))

;; testes

(horner-eval 2 (list 0 0 0 1))
; x³ for x=2 (8)

(horner-eval 4 (list 1 1 1 1))
; 1 + x + x² + x³ for x=4 (85)

(horner-eval -1 (list 1 2 3 4 5))
; 1 + 2x + 3x² + 4x³ + 5x⁴ for x=-1 (3)
