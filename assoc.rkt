#lang racket

(define ftable
  (list (cons 'add +)
        (cons 'sub -)
        ...))


(assoc 'add ftable)
((cdr (assoc 'add ftable)) 12 12)
