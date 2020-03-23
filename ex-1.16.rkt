#lang racket

(require racket/trace)

(define (expt1 b n)
  (if (= n 0)
      1
      (* b (expt1 b (- n 1)))))

(define (expt2 b n)
  (expt-iter b n 1))

(define (expt-iter b counter product)
  (if (= counter 0)
      product
      (expt-iter b
                (- counter 1)
                (* b product)))) 


(define (even? n)
  (= (remainder n 2) 0))

(define (square n)
  (* n n))

(define (fast-expt1 b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt1 b (/ n 2))))
        (else (* b (fast-expt1 b (- n 1))))))


(define (aux a b n)
  (cond ((= n 0) a)
        ((even? n)
         (aux a (* b b) (/ n 2)))
        (else
         (aux (* a b) b (- n 1)))))

(define (fast-expt2 b n)
  (aux 1 b n))


(trace aux expt1 expt-iter fast-expt1)

;; (fast-expt-i 1 2 4)
