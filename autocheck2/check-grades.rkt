#lang racket

(require rackunit)

(require "suite.rkt")

(define (grade->string g)
  (~a (car g) "/" (cdr g)))

(define (add-grade g val)
  (cons (+ (car g) val) (add1 (cdr g))))

(define (sub-grades g1 g2)
  (cons (- (car g1) (car g2)) (- (cdr g1) (cdr g2))))


(define grades
  (foldts-test-suite
 
   (lambda (suite name before after seed)
     (displayln name)
     seed)
 
   (lambda (suite name before after seed kid-seed)
     (displayln (grade->string (sub-grades kid-seed seed)))
     (displayln "\n\n")
     kid-seed)
 
   (lambda (case name action seed)
     (display (~a "\t" name "\t"))
     (cond
       ((test-success? (run-test-case name action))
        (displayln "OK")
        (add-grade seed 1))
       (else
        (displayln "ERROR")
        (add-grade seed 0))))

   (cons 0 0)
   suite))
