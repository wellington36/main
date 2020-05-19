(define (next-to x y)
    (< (abs (- x y)) 0.1))

(define (test v1 op v2)

    (define (right v)
        (display "#ok -> retornou ")
        (displayln v))

    (define (error v)
        (display "#erro -> retornou ")
        (displayln v))
    
    (if (op v1 v2)
        (right v1)
        (error v1)))


(display "(product identity 1 add1 10) ")
(test (product identity 1 add1 10) = 3628800)

(display "(product-i identity 1 add1 10) ")
(test (product-i identity 1 add1 10) = 3628800)

