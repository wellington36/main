#lang racket

(require "../compact.rkt")
(require "../ex-2.7.rkt")
(require "../ex-2.8.rkt")
(require "../ex-2.10.rkt")
(require "../ex-2.12.rkt")

(require rackunit)

(define epsilon 0.001)

(define (check-equal-intervals? a b)
  (check-= (lower-bound a) (lower-bound b) epsilon)
  (check-= (upper-bound a) (upper-bound b) epsilon))

(define suite
  (test-suite "lista-3"
              (test-suite "compact"
                          (test-case "compact.1"
                                     (check-equal? (compact '(1 1 1 1 2 2 2 3 4 5 3))
                                                   '((4 1) (3 2) 3 4 5 3)))
                          (test-case "compact.2"
                                     (check-equal? (compact '(6 6 7 7 7 8 1 1 2 1 1 1 1 1))
                                                   '((2 6) (3 7) 8 (2 1) 2 (5 1))))
                         
                          (test-case "uncompact.1"
                                     (check-equal? (uncompact '((2 1) 2 5 (3 3)))
                                                   '(1 1 2 5 3 3 3)))
                          (test-case "uncompact.2"
                                     (check-equal? (uncompact '(1 (4 3) 2 8 3))
                                                   '(1 3 3 3 3 2 8 3))))
              (test-suite "ex-2.7"
                          (test-case "upper-bound.1"
                                     (check-equal? (upper-bound (make-interval 4 6))
                                                   6))
                          (test-case "upper-bound.2"
                                     (check-equal? (upper-bound (make-interval 5 1))
                                                   5))
                         
                          (test-case "lower-bound.1"
                                     (check-equal? (lower-bound (make-interval 1 9))
                                                   1))
                          (test-case "lower-bound.2"
                                     (check-equal? (lower-bound (make-interval 10 3))
                                                   3)))
              (test-suite "ex-2.8"
                          (test-case "sub-interval.1"
                                     (check-equal-intervals? (sub-interval (make-interval 5 2)
                                                                           (make-interval 1 3))
                                                             (make-interval -1 4)))
                          (test-case "sub-interval.2"
                                     (check-equal-intervals? (sub-interval (make-interval 4 8)
                                                                           (make-interval 5 -4))
                                                             (make-interval -1 12)))
                          (test-case "sub-interval.3"
                                     (check-equal-intervals? (sub-interval (make-interval 0 0)
                                                                           (make-interval 2 3))
                                                             (make-interval -3 -2)))
                          (test-case "sub-interval.4"
                                     (check-equal-intervals? (sub-interval (make-interval 10 1)
                                                                           (make-interval 0 3))
                                                             (make-interval -2 10))))

              (test-suite "ex-2.10"
                          (test-case "div-interval.1"
                                     (check-exn exn:fail?
                                                (lambda ()
                                                  (div-interval (make-interval -1 -2)
                                                                (make-interval 0 2)))))
                          (test-case "div-interval.2"
                                     (check-exn exn:fail?
                                                (lambda ()
                                                  (div-interval (make-interval 5 6)
                                                                (make-interval -2 2)))))
                          (test-case "div-interval.3"
                                     (check-exn exn:fail?
                                                (lambda ()
                                                  (div-interval (make-interval 0 4)
                                                                (make-interval 3 -2)))))
                          (test-case "div-interval.4"
                                     (check-equal-intervals? (div-interval (make-interval -9 -4)
                                                                           (make-interval 1/2 2))
                                                             (make-interval -18 -2))))

              (test-suite "ex-2.12"
                          (test-case "make-center-percent.1"
                                     (check-equal-intervals? (make-center-percent 20 50)
                                                             (make-interval 10 30)))
                          (test-case "make-center-percent.2"
                                     (check-equal-intervals? (make-center-percent 360 20)
                                                             (make-interval 288 432)))

                          (test-case "percent.1"
                                     (check-= (percent (make-interval 9 11)) 10 epsilon))
                          (test-case "percent.2"
                                     (check-= (percent (make-interval 90 110)) 10 epsilon)))))

(provide suite)
