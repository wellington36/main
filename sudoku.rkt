#lang racket

;; @author Daniel Csillag
;; @what   Sudoku solver, based off https://youtu.be/G_UYXzGuqvM.
;;
;; NOTE: if run from the Racket REPL, it prints the grids nicely.

; I'll be using a list of lists for representing the sudoku grid. It turned out *way* more elegant than using matrices.

; Is `x` a member of list `lst`?
(define (member? x lst)
  (ormap (curry = x) lst))

; Is `x` a member of grid `grid`?
(define (grid-member grid x)
  (ormap ((curry member?) x) grid))

; Get entry `(i,j)` at grid `grid`
(define (grid-ref grid pos)
  (list-ref (list-ref grid (car pos)) (car (cdr pos))))

; Enumerate a list: '(a b c)  →  '((0 . a) (1 . b) (2 . c))
(define (enumerate lst)
  (map cons (range 0 (length lst)) lst))

; Find the first `(i,j)` in grid `grid` such that `(grid-ref grid (list i j))` equals `x`
(define (find-first-in-grid grid x)
  (car (filter cdr
               (enumerate (map (curryr index-of x)
                               grid)))))

; Get the `j`th column in grid `grid`
(define (list-ref-transpose grid j)
  (map (curryr list-ref j) grid))

; Get the square in grid `grid` that contains `(i,j)`
(define (grid-square grid i j)
  (let ([si (* 3 (floor (/ i 3)))]
        [sj (* 3 (floor (/ j 3)))])
    (map (curry grid-ref grid) (cartesian-product (range si (+ si 3))
                                                  (range sj (+ sj 3))))))

; Set the entry at `(i,j)` in grid `grid` to `n`
(define (grid-set grid i j n)
  (list-set grid i (list-set (list-ref grid i) j n)))

; Check if it's possible to *insert* `n` at `(i,j)` in grid `grid`
(define (is-possible grid i j n)
  (not (or (member? n (list-ref grid i))            ; Same row
           (member? n (list-ref-transpose grid j))  ; Same column
           (member? n (grid-square grid i j)))))    ; Same grid-square


; Some implementations of the `solve(grid)` function...
; (define (solve grid)
;   (if (grid-member grid 0)
;       (let ([i (car (find-first-in-grid grid 0))]
;             [j (cdr (find-first-in-grid grid 0))])
;         (foldl (lambda (n grid)
;                  (if (is-possible grid i j n)
;                      (grid-set (solve (grid-set grid i j n))
;                                i j 0)
;                      grid))
;                grid
;                (range 1 10)))
;       (print grid)))

; (define (solve grid)
;   (if (grid-member grid 0)
;       (let ([i (car (find-first-in-grid grid 0))]
;             [j (cdr (find-first-in-grid grid 0))])
;         (foldl (lambda (n grid)
;                  (if (not (is-possible grid i j n))
;                      grid
;                      (let ([solved (solve (grid-set grid i j n))])
;                        (if (grid-member solved 0)
;                            (grid-set solved i j 0)
;                            solved))))
;                grid
;                (range 1 10)))
;       grid))

; (define (solve grid)
;   (if (not (grid-member grid 0))
;       grid
;       (let ([i (car (find-first-in-grid grid 0))]
;             [j (cdr (find-first-in-grid grid 0))])
;         (foldl (lambda (n grid)
;                  (if (not (is-possible grid i j n))
;                      grid
;                      (let ([solved (solve (grid-set grid i j n))])
;                        (if (grid-member solved 0)
;                            (grid-set solved i j 0)
;                            solved))))
;                grid
;                (range 1 10)))))

(define (solve grid)
  (cond
    [(not (grid-member grid 0)) grid]
    [else
      (define ij (find-first-in-grid grid 0))
      (define i  (car ij))
      (define j  (cdr ij))
      (foldl (lambda (n grid)
               (cond
                 [(not (is-possible grid i j n)) grid]
                 [else
                   (define solved (solve (grid-set grid i j n)))
                   (if (grid-member solved 0)
                       (grid-set solved i j 0)
                       solved)]))
             grid
             (range 1 10))]))


; Some test matrices...
(define test-grid
  [list [list 8 9 0   7 0 0   0 1 0]
        [list 7 0 6   4 8 0   0 0 0]
        [list 0 0 3   0 1 0   7 4 8]
        ;
        [list 0 0 5   0 0 0   0 0 0]
        [list 6 0 0   0 0 8   0 3 2]
        [list 9 0 0   0 0 0   1 7 0]
        ;
        [list 0 0 0   0 0 5   0 2 0]
        [list 0 0 0   8 6 0   0 0 7]
        [list 0 0 0   9 0 7   0 0 1]])

(define test-grid2
  [list [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]
        ;
        [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]
        ;
        [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]
        [list 0 0 0   0 0 0   0 0 0]])

(define test-grid3
  [list [list 0 0 0   0 0 0   6 3 4]
        [list 0 0 0   0 9 1   0 8 0]
        [list 0 0 0   0 0 2   0 1 0]
        ;
        [list 1 0 0   0 0 0   0 0 7]
        [list 0 0 8   0 0 0   4 0 0]
        [list 0 0 9   7 0 5   0 0 0]
        ;
        [list 0 0 0   0 6 0   0 0 0]
        [list 0 4 0   0 3 0   0 0 8]
        [list 6 3 0   1 0 0   0 0 0]])

; Finally, run it!
(solve test-grid)
(solve test-grid2)
(solve test-grid3)

;; vim: fdc=3
