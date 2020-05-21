#lang racket

(require "ex-2.75.rkt")
(require rackunit)
  
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


; testes

(let* ((c1 (make-from-real-imag 1 2))
       (c2 (make-from-real-imag 3 -2))
       (cs (add-complex c1 c2))
       (cm (mul-complex c1 c2)))
  (check-equal? (real-part (add-complex c2 c1))
                (real-part (add-complex c1 c2)))

  (check-equal? (imag-part (sub-complex cs c2))
                (imag-part c1))

  (check-= (real-part (div-complex cm c2)) (real-part c1) 0.01)

  (check-equal? (real-part (mul-complex c1 c2))
                (real-part (mul-complex c2 c1)))
  
  (check-= (magnitude cm) 8.06 0.01)
  (check-= (magnitude (div-complex c1 c2)) 0.62 0.01))




