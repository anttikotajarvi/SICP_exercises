#lang sicp
(#%require sicp-lib/arithmetic)
;; Basic term 
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

;; This is very weak but I think will be fine for the current
;;  add-terms and mul-terms functions.
(define (adjoin-term term term-list)
  (if (=zero? (coeff term))
      term-list
      (let ([target-order (order term)]
            [next-order (length term-list)])
        (cond [(= target-order next-order)
               (cons (coeff term) term-list)]
              [(> target-order next-order)
               (adjoin-term term (cons 0 term-list))]
              [else
               (error "term order too small: ADJOIN-TERM"
                      (list term term-list))]))))

      
(define (the-empty-termlist) '())
(define (first-term term-list)
  (make-term (- (length term-list) 1)
             (car term-list)))
(define (rest-terms term-list) (cdr term-list))

(define (empty-termlist? term-list) (null? term-list))
(define (=zero?-termlist terms)
  (cond ((empty-termlist? terms) true)
        ((=zero?-term (first-term terms))
         (=zero?-termlist (rest-terms terms)))
        (else false)))

(define (negate-termlist terms)
  (map negate terms))

(#%provide adjoin-term the-empty-termlist first-term rest-terms
           empty-termlist? =zero?-termlist empty-termlist? 
           negate-termlist make-term order coeff)
