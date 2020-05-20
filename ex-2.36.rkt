#lang racket

(require rackunit)

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      empty
      (cons (foldr op init (map (λ (s) (car s)) seqs))
            (accumulate-n op init (map (λ (s) (cdr s)) seqs)))))


;; testes

(check-equal? (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
              '(22 26 30))

(check-equal? (accumulate-n * 1 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))
              '(280 880 1944))

(check-equal? (accumulate-n + 0 '((9 8 7 6) (1 1 1 1) (4 3 2 1)))
              '(14 12 10 8))
