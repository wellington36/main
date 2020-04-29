#lang racket

(require "interfaces.rkt") 

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))
  
;; teste

(enumerate-tree '(1 (2 3) (8 9)))
(count-leaves '(1 (2 3) (8 9)))


