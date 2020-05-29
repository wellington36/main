#lang racket

; ChangeLog:
; 1. In ex-2.78 we have introduced the 'sheme-number

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number) 
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 
         'scheme-number)
        ((pair? datum)
         (car datum))
        (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (cond ((number? datum) 
         datum)
        ((pair? datum)
         (cdr datum))
        (error "Bad tagged datum: CONTENTS" datum)))


(provide attach-tag type-tag contents)
