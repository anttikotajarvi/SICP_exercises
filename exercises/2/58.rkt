
; ______________________________________________________________
; Exercise 2.58: Suppose we want to modify the differentiation 
;  profram so that it works with ordinary mathematical notation,
;  in which + and * are infix rather than prefix operators.
; Since the differentiation program is defined in terms of 
;  abstract data, we can modify it to work with different 
;  representations of expressions solely by changing the 
;  predicates, selectors, and constructors that define the 
;  representation of the algebraic expressions on which the 
;  differentiator is to operate.
; a. Show how to do this in order to differentiate algebraic 
;    expressions presented in infix form, such as 
;    (x + (3 * (x + (y 2)))).  To simplify the task, assume that
;    + and * always take two arguments and that expressions are 
;   fully parenthesized.
;
; b. The problem becomes substantially harder if we allow 
;    standard algebraic notation, such as (x + 3 * (x + y + 2)),
;    which drops unnecessary parentheses and assumes that 
;    multiplication is done before addittion.  Can you design 
;    appropriate predicates, selectors and constructors for this
;    notation such that our derivative program still works?
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

; Not too happy with this solution, couldn't come up with any 
;  nice simplification methods to jam into the the selectors.

;; Sum
(define (make-sum-infix a1 a2)
  (cond [(=number? a1 0) a2]
        [(=number? a2 0) a1]
        [(and (number? a1) 
              (number? a2))
          (+ a1 a2)]
        [else (list a1 '+ a2)]))
(define (sum-infix? exp)
  (and (pair? exp)
       (memq '+ exp)))

(define (addend-infix exp)
  (normalize-piece (take-until '+ exp)))
(define (augend-infix exp) 
  (normalize-piece (take-after '+ exp)))


;; Product
(define (make-product-infix m1 m2) 
  (cond [(or (=number? m1 0) (=number? m2 0)) 0]
        [(=number? m1 1) m2]
        [(=number? m2 1) m1]
        [(and (number? m1) (number? m2)) (* m1 m2)]
        [else (list m1 '* m2)]))

(define (product-infix? exp)
  (and (pair? exp)
       (memq '* exp)))

(define (multiplier-infix exp) (normalize-piece (take-until '* exp)))
(define (multiplicand-infix exp) (normalize-piece (take-after '* exp)))

;; Deriv-infix (to keep the previous tests intact)
;; Exponents are removed
(define (deriv-infix exp var)
  (cond [(number? exp) 0]
        [(variable? exp) (if (same-variable? exp var) 1 0)]
        [(sum-infix? exp)
         (make-sum-infix (deriv-infix (addend-infix exp) var)
                         (deriv-infix (augend-infix exp) var))]
        [(product-infix? exp)
         (make-sum-infix
           (make-product-infix (multiplier-infix exp)
                               (deriv-infix (multiplicand-infix exp) var))
           (make-product-infix (deriv-infix (multiplier-infix exp) var)
                               (multiplicand-infix exp)))]
        [else 
         (error "unknown expression type: DERIV" exp)]))

;; Utility
(define (normalize-piece piece)
  (if (null? (cdr piece))
      (car piece)
      piece))
(define (take-until op xs)
  (cond [(null? xs) '()]
        [(eq? (car xs) op) '()]
        [else (cons (car xs)
                    (take-until op (cdr xs)))]))

(define (take-after op xs)
  (cond [(null? xs) '()]
        [(eq? (car xs) op) (cdr xs)]
        [else (take-after op (cdr xs))]))

(inspect (deriv-infix '(x + 3 * (x + y + 2)) 'x)) ; 4
