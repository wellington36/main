#lang racket

;; https://codology.net/post/sicp-solution-exercise-2-3/

;; segment

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment s)
  (car s))

(define (end-segment s)
  (cdr s))

(define (midpoint-segment s)
  (let ((x (/ (+ (x-point (start-segment s))
                 (x-point (end-segment s)))
              2))
        (y (/ (+ (y-point (start-segment s))
                 (y-point (end-segment s)))
              2)))
    (make-point x y)))
           
    

;; point

(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))


;; rectangle


(define (make-rectangle p1 p2 p3 p4)
  ...
  (cons (cons p1 p2)
        (cons p3 p4)))

(define (distance p1 p2)
  ...)

(define (rectangle-width r)
  ...)

(define (rectangle-height r)
  ...)

; rectangle -> number
(define (rectangle-area r)
  (* (rectangle-width r)
     (rectangle-height r)))

; rectangle -> number
(define (rectangle-perimeter r)
  (+ (* 2 (rectangle-width r))
     (* 2 (rectangle-height r))))
