#lang racket

;; https://docs.racket-lang.org/guide/hash-tables.html

(require "tag-system.rkt")

;;; Operations and types table

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
	    false))
      false))

(define (show)
  table)

(provide put get show start)

;;; Coercion Table

(define coercion-table (make-hash))

(define (start-coercion)
  (set! coercion-table (make-hash)))

(define (put-coercion type1 type2 proc-coercion)
  (if (hash-has-key? coercion-table type1)
      (hash-set! (hash-ref coercion-table type1) type2 proc-coercion)
      (hash-set! coercion-table type1 (make-hash (list (cons type2 proc-coercion))))))

(define (get-coercion type1 type2)
  (if (hash-has-key? coercion-table type1)
      (let ((tbo (hash-ref coercion-table type1)))
	(if (hash-has-key? tbo type2)
	    (hash-ref tbo type2)
	    false))
      false))

(define (show-coercion)
  coercion-table)

;;; Apply Generic

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types -- APPLY-GENERIC"
           (list op type-tags))))))

(provide apply-generic put-coercion get-coercion start-coercion show-coercion)


