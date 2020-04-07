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

(display "(sqrt 9) ")
(test (sqrt 9) next-to 3)

(display "(sqrt 6) ")
(test (sqrt 6) next-to 2.45)

(display "(sqrt 2) ")
(test (sqrt 2) next-to 1.414)

(display "(sqrt 350) ")
(test (sqrt 350) next-to 18.708)