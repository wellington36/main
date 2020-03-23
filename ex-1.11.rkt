#lang racket

(require racket/trace)

(define (f1 n) 
  (cond ((< n 3) n) 
        (else (+ (f1 (- n 1)) 
                 (* 2 (f1 (- n 2))) 
                 (* 3 (f1 (- n 3)))))))

(define (f2 n) 
  (define (fa a b c count) 
    (cond ((< n 3) n) 
          ((<= count 0) a) 
          (else (fa (+ a (* 2 b) (* 3 c)) a b (- count 1))))) 
  (fa 2 1 0 (- n 2)))

(trace f1)

;(f2 4) =
;(fa 2 1 0 2) =
;(fa 4 2 1 1) =
;(fa 11 4 2 0) = 11



