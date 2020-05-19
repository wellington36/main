#lang racket

;; autor: Caio Lins
;; 
;; Cada sudoku é representado como uma lista de listas (as linhas do
;; sudoku).
;;
;; A função <solve> chama a função <solve-inner>, a qual
;; analisa, em ordem, todas possibilidades para
;; completar o sudoku (usando como critéiro de possibilidade o
;; predicado <possible?>), mas coloca em uma lista apenas aquelas 
;; nas quais as modificações ocorreram de modo a ser possível 
;; completá-lo, terminando as chamadas recursivas que chegam 
;; em becos sem saída.
;;
;; Isso é feito por meio da alterção de <output>, uma variável "global"
;; no escopo da função <solve-inner>.
;; Nas chamadas em que o sudoku é completado, utiliza-se a função 
;; <set!> para mudar o valor de output para uma <cons> do <output>
;; (cujo valor inicial é <empty>) com a solução. Nas chamadas que 
;; chegam a becos sem saída, é feito basicamente um <(set! output output)>
;; de modo que o <output> permanece inalterado.
;: 
;; Essa solução para o problema de colocar os resultados em uma lista
;; foi dada por Daniel Csillag.



(define (solve sdk)

  (define (solve-inner sdk output)

   ; retorna a i-ésima linha do sudoku (lembrando que i está entre 0 e
   ; 8).
   (define (get-line i)
     (list-ref sdk i))

   ; retorna a j-ésima coluna do sudoku.
   (define (get-column j)
     (map (lambda (line) (list-ref line j))
	  sdk))

   ; retorna a entrada na i-ésima linha e j-ésima coluna do sudoku.
   (define (get-entry i j)
     (list-ref (list-ref sdk i) j))

   ; retorna uma lista com as entradas do quadrado que contém o
   ; elemento na i-ésima linha e j-ésima coluna.
   (define (get-square i j)
     (let* ([x-min (* 3 (quotient j 3))]
	    [y-min (* 3 (quotient i 3))])
       (for*/list ([column (in-range x-min (+ x-min 3))]
		   [line (in-range y-min (+ y-min 3))])
	 (get-entry line column))))

   ; muda a entrada da i-ésima linha e j-ésima coluna para o número k
   ; (a rigor cria-se um novo sudoku, mudando apenas a entrada
   ; especificada para o número k)
   (define (set-entry i j k)
     (list-set sdk
	       i
	       (list-set (list-ref sdk i) j k)))

   ; verifica se é possível colocar o número k na entrada da i-ésima
   ; linha e j-ésima coluna.
   (define (possible? i j k)
     (define linha-ok?
       (andmap (lambda (x) (not (= x k))) (get-line i)))
     (define coluna-ok?
       (andmap (lambda (x) (not (= x k))) (get-column j)))
     (define quadrado-ok?
       (andmap (lambda (x) (not (= x k))) (get-square i j)))
     (and linha-ok? coluna-ok? quadrado-ok?))

   (define (is-over? i j)
     (and (= i 8) (= j 8)
	  (not (= (get-entry i j) 0))))

   (define (is-printed? i j k)
     (and (= i j 8) 
	  (not (= (get-entry i j) 0))
	  (> k 1)))

   (for* ([i (in-range 9)]			
	  [j (in-range 9)]			
	  #:when (or (= (get-entry i j) 0)	
		     (is-over? i j))		
	  [k (in-range 1 11)]			
	  #:break (or (= k 10)			
		      (is-printed? i j k))	   
	  #:when (or (possible? i j k)		
		     (is-over? i j)))
     (if (is-over? i j)
	 (set! output (cons sdk output))  
	 (set! output (solve-inner (set-entry i j k) output))))
   output)

  (solve-inner sdk null))

;grid with two possible solutions
(define grid-1 '((9 0 6  0 7 0  4 0 3)
                 (0 0 0  4 0 0  2 0 0)
                 (0 7 0  0 2 3  0 1 0)

                 (5 0 0  0 0 0  1 0 0)
                 (0 4 0  2 0 8  0 6 0)
                 (0 0 3  0 0 0  0 0 5)

                 (0 3 0  7 0 0  0 5 0)
                 (0 0 7  0 0 5  0 0 0)
                 (4 0 5  0 1 0  7 0 8)))

(solve grid-1)

;grid with only one solution
(define grid-2 '((0 0 0  1 0 5  0 6 8)
		 (0 0 0  0 0 0  7 0 1)
		 (9 0 1  0 0 0  0 3 0)

		 (0 0 7  0 2 6  0 0 0)
		 (5 0 0  0 0 0  0 0 3)
		 (0 0 0  8 7 0  4 0 0)

		 (0 3 0  0 0 0  8 0 5)
		 (1 0 5  0 0 0  0 0 0)
		 (7 9 0  4 0 1  0 0 0)))

(solve grid-2)
