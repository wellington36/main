#lang sicp

(define x '((a b) c d))
(define y '(e f))
(set-car! x y)

(define m (set-car! x y)) ; what value of m?

;; get-new-pair does not exists


(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
(define w (append! x y))


(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)


;; vide ex-2.39.rkt e ex-2.18.rkt

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))
