#lang racket

;Drop every N'th element from a list 

(define (drop a-list n)
  (define (drop-aux a-list r-list n)
    (cond ((empty? a-list) r-list)
          ((= n 0) r-list)
          (else (drop-aux (cdr a-list)
                          (append  r-list (list (car a-list)))
                          (- n 1)))))
  (drop-aux a-list '() n))

(provide drop)