#lang racket

;; utils

(require "fibonacci.rkt")
(require "interfaces.rkt")

(define (square x) (* x x))


(define (sum-odd-squares-1 tree)
  (cond ((empty? tree) 0)  
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares-1 (car tree))
                 (sum-odd-squares-1 (cdr tree))))))

(define (even-fibs-1 n)
  (define (next k)
    (if (> k n)
        empty
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

;; but

(map square (list 1 2 3 4 5))
(filter odd? (list 1 2 3 4 5))

(accumulate + 0 (list 1 2 3 4 5))
(accumulate cons empty (list 1 2 3 4 5))


;; enumerations

(enumerate-interval 2 7)
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))

;; new versions

(define (sum-odd-squares-2 tree)
  (accumulate +
              0
              (map square
                   (filter odd?
                           (enumerate-tree tree)))))

(sum-odd-squares-2 '(1 (2 (3 4)) 5))
(sum-odd-squares-1 '(1 (2 (3 4)) 5))


(define (even-fibs-2 n)
  (accumulate cons
              empty
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))

(even-fibs-1 100)
(even-fibs-2 100)

;; reusing

(define (list-fib-squares n)
  (accumulate cons
              empty
              (map square
                   (map fib
                        (enumerate-interval 0 n)))))

(list-fib-squares 10)


(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))

(product-of-squares-of-odd-elements (list 1 2 3 4 5))
