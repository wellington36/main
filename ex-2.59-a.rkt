#lang racket

(require "set.rkt")

(define (union-set set1 set2) 
   (if (empty? set1) 
     set2 
     (union-set (cdr set1) (adjoin-set (car set1) set2))))
