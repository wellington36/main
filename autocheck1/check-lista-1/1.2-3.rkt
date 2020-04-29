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


(display "(sum-of-squares-max3 4 5 6) ")
(test (sum-of-squares-max3 4 5 6) = 61)

(display "(sum-of-squares-max3 1 0 2) ")
(test (sum-of-squares-max3 1 0 2) = 5)

(display "(sum-of-squares-max3 3 8 3) ")
(test (sum-of-squares-max3 3 8 3) = 73)

(display "(sum-of-squares-max3 9 9 9) ")
(test (sum-of-squares-max3 9 9 9) = 162)
