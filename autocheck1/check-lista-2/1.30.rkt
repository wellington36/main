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


(display "(* 8 (sum (lambda (x) (/ 1.0 (* x (+ x 2)))) 1 (lambda (x) (+ x 4)) 10000)) ")
(test (* 8 (sum (lambda (x) (/ 1.0 (* x (+ x 2)))) 1 (lambda (x) (+ x 4)) 10000)) next-to pi)

