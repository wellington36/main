#lang racket

;Duplicate the elements of a list.

(define (dupli a-list)
  (if (empty? a-list)
      '()
      (cons (car a-list) (cons (car a-list)
                               (dupli (cdr a-list))))))

(provide dupli)
