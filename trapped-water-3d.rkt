#lang racket
#| autor: Rafael Portácio
 trabalharemos com uma ditribuição de números semelhante a uma matriz.

Considerações iniciais para a ideia utilizada nesse código: note que seria
impossível que tivessemos uma coluna de água mais alta do que a mais alta coluna da matriz.
Assim como seria impossível um "bloco" de água não ser cercado pelos 4 lados (pois a água escorreria).
|#

(require "trapped-water.rkt")

(define (maxmtrx m) (maxlst (map maxlst m))) ;recebe uma lista de listas de números e devolve o maior elemento

(define (pos i j) (cons i j)) ;definição de ponto da distribuição

(define (elt-i-j m p) ;retorna o elemento na posição p da nossa distribuição
  (if (and (col-limit? m p) (lin-limit? m p))
      (list-ref (list-ref m (- (lin-pos p) 1)) (- (col-pos p) 1))
      0))

(define init (pos 1 1)) ;ponto inicial da distribuição

(define end-point 'over) ;retorna símbolo indicando que a matriz terminou de ser analisada 

(define (lin-pos p) (car p)) ; número da linha que o ponto está

(define (col-pos p) (cdr p)) ; número da coluna que o ponto está

(define (lin-limit? m p) ;o ponto p está numa linha válida da matriz m?
  (and (>= (length m) (lin-pos p)) (> (lin-pos p) 0)))

(define (col-limit? m p) ;o ponto p está numa coluna válida da matriz m?
  (and (>= (length (list-ref m 1)) (col-pos p)) (> (col-pos p) 0)))
  
(define (last-lin? m p) ;o ponto p está na última linha da matriz m?
  (= (length m) (lin-pos p)))

(define (last-col? m p) ;o ponto p está na última coluna da matriz m?
  (= (length (list-ref m (- (lin-pos p) 1))) (col-pos p)))
  
(define (next m p) ;o próximo ponto após p
  (let ([i (lin-pos p)] [j (col-pos p)])
    (cond ((not (last-col? m p)) (pos i (+ j 1)))
          ((and (last-col? m p) (not (last-lin? m p))) (pos (+ i 1) 1))
          (#t end-point))))

(define (change m p v) ;muda matriz m (transformando o elemento na posição p no valor v)
  (list-set m (- (lin-pos p) 1) (list-set (list-ref m (- (lin-pos p) 1)) (- (col-pos p) 1) v)))

(define (trapped-water m-orig) ;recebe uma matriz e devolve ela "pós-chuva" onde teremos colunas de água inclusas
;;note que m-orig é a matriz original (sem colunas d'água)
  (define (possible-escape? m p) ;é possível que a água escape dessa posição?
    (let ([i (lin-pos p)] [j (col-pos p)])
      (> (elt-i-j m p)
         (min (elt-i-j m (pos (+ i 1) j))
              (elt-i-j m (pos (- i 1) j))
              (elt-i-j m (pos i (+ j 1)))
              (elt-i-j m (pos i (- j 1)))))))
  
  (define (put-water m) ; põe água em excesso em toda a matriz m (o excesso será removido pela waterflow)
    (build-list (length m) (λ (x) (build-list (length (first m)) (λ (x) (maxmtrx m))))))

  (define (waterflow m p) ;fluxo de água (remove a água que tem como escapar, analisando ponto a ponto)
    (cond ((equal? p end-point) m)
          ((equal? (elt-i-j m p) (elt-i-j m-orig p)) (waterflow m (next m p))) ;testa se não há água acima da coluna neste ponto
          ((possible-escape? m p) (waterflow (change m p (- (elt-i-j m p) 1)) (next m p))) ;essa água que há, pode escapar?
          (#t (waterflow m (next m p))))) ;há água, mas ela não pode escapar então avançamos para a analíse do próximo ponto

  (define (improve-the-flow m) ;chama a waterflow quantas vezes for necessário para que todo o excesso seja removido 
    (cond ((equal? (waterflow m init) m) m)
          (#t (improve-the-flow (waterflow m init)))))

  (improve-the-flow (put-water m-orig)))

(define (print-mtrx m) ;printa a lista de listas
  (display (car m))
  (newline)
  (if (empty? (cdr m)) (newline) (print-mtrx (cdr m))))

(define (amount-water k) ;retorna a quantidade de água armazenada
  (- (foldr + 0 (map (λ (x) (foldr + 0 x)) (trapped-water k)))
     (foldr + 0 (map (λ (x) (foldr + 0 x)) k))))


#|(print-mtrx (trapped-water (list (list 9 9 9)
                                 (list 9 0 9)
                                 (list 9 3 2))))

(display "amount:")

(amount-water (list (list 9 9 9)
                    (list 9 0 9)
                    (list 9 3 2)))
(newline)

(print-mtrx (trapped-water (list (list 9 9 9 9 9 9 9 9 9)
                                 (list 3 2 0 4 5 3 6 8 2)
                                 (list 9 9 9 9 9 9 9 9 9))))

(display "amount:")

(amount-water (list (list 9 9 9 9 9 9 9 9 9)
                    (list 3 2 0 4 5 3 6 8 2)
                    (list 9 9 9 9 9 9 9 9 9)))
(newline)
(print-mtrx (trapped-water (list (list 9 7 6 6 7 8 4 6 3)
                                 (list 8 0 0 4 0 0 2 0 4)
                                 (list 6 7 4 0 6 3 0 3 0)
                                 (list 5 0 0 4 0 0 5 0 2)
                                 (list 8 4 0 2 5 8 0 6 0)
                                 (list 9 0 3 0 0 9 0 0 5)
                                 (list 5 3 0 7 0 6 0 5 3)
                                 (list 0 0 7 0 0 5 0 8 4)
                                 (list 4 0 5 6 4 0 7 1 8))))

(display "amount:")

(amount-water (list (list 9 7 6 6 7 8 4 6 3)
                    (list 8 0 0 4 0 0 2 0 4)
                    (list 6 7 4 0 6 3 0 3 0)
                    (list 5 0 0 4 0 0 5 0 2)
                    (list 8 4 0 2 5 8 0 6 0)
                    (list 9 0 3 0 0 9 0 0 5)
                    (list 5 3 0 7 0 6 0 5 3)
                    (list 0 0 7 0 0 5 0 8 4)
                    (list 4 0 5 6 4 0 7 1 8)))
|#