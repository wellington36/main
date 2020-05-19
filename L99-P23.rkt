#lang racket

(require "L99-P03.rkt")
(require "L99-P20.rkt")

(define (rnd-select alist num)
  (define (aux alist selected)
    (if (equal? num (length selected))
        selected
        (let ((rpos (+ (random (length alist)) 1)))
          (aux (remove-at alist rpos)
               (cons (element-at alist rpos) selected)))))
  (aux alist empty))


(provide rnd-select)
