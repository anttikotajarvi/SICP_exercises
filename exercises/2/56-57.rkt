; SICP 2.3.2
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Symbolic Differentiation
; Exercise 2.56:
; Show how to extend the basic differentiator to handle more 
;  kinds of expressions.  For instance, implement a 
;  differentiation rule
;  d(u^n)           du
;  ______ = nu^(n-1)__
;    dx             dx
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")



(define (deriv exp var)
  (cond [(number? exp) 0]
        [(variable? exp) (if (same-variable? exp var) 1 0)]
        [(sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var))]
        [(product? exp)
          (make-sum
            (make-product (multiplier exp)
                          (deriv (multiplicand exp) var))
            (make-product (deriv (multiplier exp) var)
                          (multiplicand exp)))]
        [(expt? exp) 
          (make-product (deriv (base exp) var)
                        (make-product (exponent exp)
                                      (make-expt
                                        (base exp)
                                        (- (exponent exp) 1))))]
        [else 
         (error "unknown expression type: DERIV" exp)]))

 
; ______________________________________________________________
; Exercise 2.57:
; Extend the differentiation program to handle sums and products
;  of arbitrary numbers of (two or more) terms.
; Then the last example above could be expressed as
;   (deriv '(* x y (+ x 3)) 'x)
; Try to do this by changing only the representation for sums 
;  and products, without changing the 'deriv' procedure at all.
; For example, the 'addend' of a sum would be the first term, 
;  and the 'augend' would be the sum of the rest of the terms.
; ______________________________________________________________
(inspect (make-sum 1 1 1))
(inspect (multiplicand (make-product 1 2 3 'x 5)))  ; (* 3 (* x 5))
(inspect (deriv '(* x y (+ x 3)) 'x))  ; (+ (* x y) (* y (+ x 3)))