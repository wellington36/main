#lang sicp

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; valor 3
(count-pairs (list 1 2 3))
;; (count-pairs (cons 1 (cons 2 (cons 3 nil)))) =
;; (+ (count-pairs 1) (count-pairs (cons 2 (cons 3 nil))) 1) =
;; (+ (count-pairs 1) (+ (count-pairs 2) (count-pairs (cons 3 nil)) 1) 1) =
;; (+ (count-pairs 1) (+ (count-pairs 2) (+ (count-pairs 3) (count-pairs nil) 1) 1) 1) =
;; (+ 0 (+ 0 (+ 0 0 1) 1) 1) = 3

;; valor 4
(define y1 (list 1))
(define y2 (cons 1 y1))
(define z1  (cons y1 y2))
(count-pairs z1)

;; valor 7
(define y3 (cons y1 y1))
(define z2 (cons y3 y3))
(count-pairs z2)

;; (count-pairs z) =
;; (+ (count-pairs y2) (count-pairs y2) 1) =
;; (+ (+ (count-pairs y1) (count-pairs y1) 1)
;;    (+ (count-pairs y1) (count-pairs y1) 1)
;;    1) =
;; (+ (+ (+ (count-pairs 1) (count-pairs empty) 1)
;;       (+ (count-pairs 1) (count-pairs empty) 1)
;;       1)
;;    (+ (+ (count-pairs 1) (count-pairs empty) 1)
;;       (+ (count-pairs 1) (count-pairs empty) 1)
;;       1)
;;    1) =
;; (+ (+ (+ 0 0 1)
;;       (+ 0 0 1)
;;       1)
;;    (+ (+ 0 0 1)
;;       (+ 0 0 1)
;;       1)
;;    1) = 7

;; loop sem retorno
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z3 (make-cycle (list 'a 'b 'c)))
;; loop sem retorno
;; (count-pairs z3)


