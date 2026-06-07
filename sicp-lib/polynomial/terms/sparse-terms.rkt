#lang sicp
(#%require sicp-lib/arithmetic)
(define (adjoin-term term term-list)
  (if (=zero? (coeff term)) 
      term-list
      (cons term term-list)))
(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))
(define (empty-termlist? term-list) (null? term-list))
(define (=zero?-termlist terms)
  (cond ((empty-termlist? terms) true)
        ((=zero?-term (first-term terms))
         (=zero?-termlist (rest-terms terms)))
        (else false)))

(define (negate-termlist terms)
  (if (empty-termlist? terms)
      the-empty-termlist
      (adjoin-term
       (negate-term (first-term terms))
       (negate-termlist (rest-terms terms)))))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(#%provide adjoin-term the-empty-termlist first-term rest-terms
           empty-termlist? =zero?-termlist empty-termlist? 
           negate-termlist make-term order coeff)
