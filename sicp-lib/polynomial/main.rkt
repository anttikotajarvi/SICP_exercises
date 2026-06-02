#lang sicp
(#%require sicp-lib/symbolic)
(#%require sicp-lib/polynomial/terms)
(#%provide install-polynomial-package 
           (all-from sicp-lib/polynomial/terms))

(define (install-polynomial-package)
  ;; internal procedures
  (define (make-poly variable term-list) (cons variable term-list))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  ;; representation of terms and term lists
  ;; (adjoin-term ... coeff) from text below)

  (define (add-poly p1 p2) 
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1) (term-list p2)))
        (error "Polys not in same var: ADD-poly" (list p1 p2))))

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
      (make-poly (variable p1)
                 (mul-terms (term-list p1) (term-list p2)))
      (error "Polys not in same var: MUL-poly" (list p1 p2))))

  ;; interface
  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial)
    (lambda (p1 p2) (tag (add-poly pq p2))))

  (put 'mul '(polynomial polynomial) 
    (lambda (p1 p2) (tag (mul-poly p1 p2))))

  (put 'make 'polynomial
    (lambda (var terms) (tag (make-poly var terms))))

'done)
