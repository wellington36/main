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


(display "(fib 3) ")
(test (fib 3) = 2)

(display "(fib 5) ")
(test (fib 5) = 5)

(display "(fib 10) ")
(test (fib 10) = 55)

(display "(fib 100) ")
(test (fib 100) = 354224848179261915075)
