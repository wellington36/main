#lang racket

;; https://docs.racket-lang.org/guide/hash-tables.html

(define table (make-hash))

(define (start)
  (set! table (make-hash)))

(define (put op type item)
  (if (hash-has-key? table op)
      (hash-set! (hash-ref table op) type item)
      (hash-set! table op (make-hash (list (cons type item))))))

(define (get op type)
  (if (hash-has-key? table op)
      (let ((tbo (hash-ref table op)))
        (if (hash-has-key? tbo type)
            (hash-ref tbo type)
            empty))
      empty))

(define (show)
  table)

(provide put get show start)


