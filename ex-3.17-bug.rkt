#lang sicp

;; Essa versão do código contém um bug. Quando o procedimento `count-pairs` é
;; chamado duas vezes seguidas com o mesmo input (mesmo no sentido de `eq?`),
;; o histórico `visited-pairs` não é reiniciado, de modo que a segunda chamada
;; retorna sempre 0. 

(define count-pairs
  (let ((visited-pairs nil))
    (lambda (x)
      (if (pair? x)
	  (if (memq x visited-pairs)
	      0
	      (begin (set! visited-pairs (cons x visited-pairs))
		     (+ (count-pairs (car x))
			(count-pairs (cdr x))
			1)))
	  0))))

;; Teste do bug

(define z (cons 1 (cons 2 (cons 3 nil))))
(count-pairs z)
(count-pairs z)
