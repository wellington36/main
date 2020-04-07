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


(display "(carmichael-number? 23) ")
(test (carmichael-number? 23) equal? #f)

(display "(carmichael-number? 955) ")
(test (carmichael-number? 955) equal? #f)

(display "(carmichael-number? 561) ")
(test (carmichael-number? 561) equal? #t)

(display "(carmichael-number? 825265) ")
(test (carmichael-number? 825265) equal? #t)
