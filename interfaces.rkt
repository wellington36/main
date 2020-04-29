#lang racket

(define (map procedure sequence)
  (if (empty? sequence)
      empty
      (cons (procedure (car sequence))
            (map procedure (cdr sequence)))))

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

(define (enumerate-tree tree)
  (cond ((empty? tree)
         empty)
        ((not (pair? tree))
         (list tree))
        (else
         (append (enumerate-tree (car tree))
                 (enumerate-tree (cdr tree))))))


(provide map filter accumulate enumerate-interval enumerate-tree)
