#lang racket

;;autor: caio lins
;
;sudoku solver.
;
;cada sudoku é representado como uma lista de listas (as linhas do sudoku).

(define (solve sdk)

  ;retorna a i-ésima linha do sudoku (lembrando que i está entre 0 e 8).
  (define (get-line i)
    (list-ref sdk i))

  ;retorna a j-ésima coluna do sudoku. 
  (define (get-column j)
    (map (lambda (line) (list-ref line j))
	 sdk))

  ;retorna a entrada na i-ésima linha e j-ésima coluna do sudoku.
  (define (get-entry i j)
    (list-ref (list-ref sdk i) j))

  ;retorna uma lista com as entradas do quadrado que contém o elemento na 
  ;i-ésima linha e j-ésima coluna.
  (define (get-square i j)
    (let* ([x-min (* 3 (quotient j 3))]
	   [y-min (* 3 (quotient i 3))])
      (for*/list ([column (in-range x-min (+ x-min 3))]
		  [line (in-range y-min (+ y-min 3))])
	(get-entry line column))))

  ;muda a entrada da i-ésima linha e j-ésima coluna para o número k (a rigor
  ;cria-se um novo sudoku, mudando apenas a entrada especificada para o núme-
  ;ro k)
  (define (set-entry i j k)
    (list-set sdk
	      i
	      (list-set (list-ref sdk i) j k)))

  ;verifica se é possível colocar o número k na entrada da i-ésima
  ;linha e j-ésima coluna.
  (define (possible? i j k)
    (define linha-ok?
      (andmap (lambda (x) (not (= x k)))
	      (get-line i)))
    (define coluna-ok?
      (andmap (lambda (x) (not (= x k)))
	      (get-column j)))
    (define quadrado-ok?
      (andmap (lambda (x) (not (= x k)))
	      (get-square i j)))
    (and linha-ok?
	 coluna-ok?
	 quadrado-ok?))

  (define (acabou? i j)
    (and (= i 8)
	 (= j 8)
	 (not (= (get-entry i j) 0))))

  (define (imprimiu? i j k)
    (and (= i j 8)
	 (> k 1)))

  (for* ([i (in-range 9)]			;em suma, a função <solve> analisa, em ordem,
	 [j (in-range 9)]			;todas possibilidades para completar o su-
	 #:when (or (= (get-entry i j) 0)	;doku (usando como critéiro de possibilida-
		    (acabou? i j))		;de o predicado <possible?>), mas imprime
	 [k (in-range 1 11)]			;apenas aquelas nas quais as modificações  
	 #:break (or (= k 10)			;ocorreram de modo a ser possível completá-lo,
		     (imprimiu? i j k))		;terminando as chamadas recursivas que chegam em
	 #:when (or (possible? i j k)		;becos sem saída.
		    (acabou? i j)))
    (if (acabou? i j)
	(begin (display sdk)
	       (newline))
	(solve (set-entry i j k)))))

(define my-sdk (list (list 9 0 6 0 7 0 4 0 3)
		     (list 0 0 0 4 0 0 2 0 0)
		     (list 0 7 0 0 2 3 0 1 0)
		     (list 5 0 0 0 0 0 1 0 0)
		     (list 0 4 0 2 0 8 0 6 0)
		     (list 0 0 3 0 0 0 0 0 5)
		     (list 0 3 0 7 0 0 0 5 0)
		     (list 0 0 7 0 0 5 0 0 0)
		     (list 4 0 5 0 1 0 7 0 8)))

(solve my-sdk)
