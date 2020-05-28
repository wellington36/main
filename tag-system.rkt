#lang racket

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number) ; ex-2.78
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) ; ex-2.78
         'scheme-number)
        ((pair? datum)
         (car datum))
        (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (cond ((number? datum) ; ex-2.78
         datum)
        ((pair? datum)
         (cdr datum))
        (error "Bad tagged datum: CONTENTS" datum)))


(provide attach-tag type-tag contents)
