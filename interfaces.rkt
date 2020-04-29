#lang racket

(define (map proc items)
  (if (empty? items)
      empty
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (filter predicate sequence)
  (cond ((empty? sequence)
         empty)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
         (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (empty? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))


(define (enumerate-interval low high)
  (if (> low high)
      empty
      (cons low (enumerate-interval (+ low 1) high))))


(provide map filter accumulate enumerate-interval)
