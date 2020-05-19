(define (abs x)
  (if (< x 0) (- x) x))

(define (next-to x y)
    (< (abs (- x y)) 0.1))

(define (test v1 op v2)

    (define (right v)
        (display "#ok -> given ")
        (displayln v))

    (define (error v)
        (display "#error -> given ")
        (displayln v))
    
    (if (op v1 v2)
        (right v1)
        (error v1)))

(display "(cube-root 8) ")
(test (cube-root 8) next-to 2)

(display "(cube-root 1) ")
(test (cube-root 1) next-to 1)

(display "(cube-root 3) ")
(test (cube-root 3) next-to 1.442)

(display "(cube-root 33) ")
(test (cube-root 33) next-to 3.207)