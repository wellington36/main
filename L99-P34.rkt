#lang racket

; Calculate Euler's totient function phi(m). Euler's so-called totient
; function phi(m) is defined as the number of positive integers r (1
; <= r < m) that are coprime to m.

; se m for primo, phi(m) será (- m 1), já que todos os naturais antes
; de m são comprime com m. dois número são comprime se seu maior
; divisor comum for igual a 1.

(define (next x) (+ x 1))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (totiente-phi m)
  (define (totiente-phi-aux a n)
    (cond ((= a n) 0)
          ((= (gcd a n) 1)
           (+ 1 (totiente-phi-aux (next a) n)))
          (else (totiente-phi-aux (next a) n))))
    (totiente-phi-aux 1 m))

; test

(totiente-phi 10)
(totiente-phi 20)
(totiente-phi 19)
(totiente-phi 11)


(provide gcd totiente-phi)
          
