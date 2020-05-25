#lang racket

(require "complex-impl.rkt")
(require "table.rkt")
(require "ex-2.78.rkt")

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-complex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

(define (equ? z1 z2)
  (and (= (real-part z1) (real-part z2))
       (= (imag-part z1) (imag-part z2))))

(define (=zero? x)
  (and (= (real-part x) 0)
       (= (imag-part x) 0)))


;; test

(require rackunit)

(define ac (make-from-real-imag 22 3))

(check-equal? (add-complex (mul-complex ac ac)
                           (add-complex ac ac))
              '(rectangular 519.0 . 138.0))
(check-equal? (div-complex (mul-complex ac ac)
                           (add-complex ac ac))
              '(polar 11.10180165558726 . 0.13552771398550073))
(check-equal? (equ? ac ac)
              #t)
(check-equal? (equ? ac (mul-complex ac ac))
              #f)
(check-equal? (=zero? ac)
              #f)
(check-equal? (=zero? (sub-complex ac ac))
              #t)

;; interface to rest of the system

(define (tag z) (attach-tag 'complex z))

(put 'add '(complex complex)
     (lambda (z1 z2) (tag (add-complex z1 z2))))

(put 'sub '(complex complex)
     (lambda (z1 z2) (tag (sub-complex z1 z2))))

(put 'mul '(complex complex)
     (lambda (z1 z2) (tag (mul-complex z1 z2))))

(put 'div '(complex complex)
     (lambda (z1 z2) (tag (div-complex z1 z2))))

(put 'make-from-real-imag 'complex
     (lambda (x y) (tag (make-from-real-imag x y))))

(put 'make-from-mag-ang 'complex
     (lambda (r a) (tag (make-from-mag-ang r a))))


(put 'equ? '(complex complex) equ?)
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)
(put '=zero? '(complex) =zero?)

