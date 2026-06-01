; SICP 2.4.3
; Chapter: Building Abstractions with Data
; Section: Multiple Representations for Abstract Data
; Subsection: Data-Directed Programming and Additivity
; Exercise 2.73:
; Section 2.3.2 described a program that performs symbolic differentiation
;
;   (define (deriv exp var)
;     (cond [(number? exp) 0]
;           [(variable? exp) (if (same-variable? exp var) 1 0)]
;           [(sum? exp) (make-sum (deriv (addend exp) var)
;                                 (deriv (augend exp) var))]
;           [(product? exp)
;             (make-sum
;               (make-product (multiplier exp)
;                             (deriv (multiplicand exp) var))
;               (make-product (deriv (multiplier exp) var)
;                             (multiplicand exp)))]
;           [(expt? exp) 
;             (make-product (deriv (base exp) var)
;                           (make-product (exponent exp)
;                                         (make-expt
;                                           (base exp)
;                                           (- (exponent exp) 1))))]
;           [else 
;            (error "unknown expression type: DERIV" exp)]))
;   
; We can regard this program as performing a dispatch on the type of the 
;  expression to be differentiated.
; In this situation the "type tag" of the datum is the algebraic operator
;  symbol (such as +) and the operation being performed is 'deriv'.
; We can transform this program int oa data-directed style by rewriting 
;  the basic derivative procedure as
;
#lang sicp
(#%require sicp-lib)
(#%require sicp-lib/generic)
(#%require (only-in sicp-lib/symbolic variable? same-variable? make-product make-expt))
   (define (deriv exp var)
     (cond [(number? exp) 0]
           [(variable? exp) (if (same-variable? exp var) 1 0)]
           [else ((get 'deriv (operator exp))
                   (operands exp) var)]))
   (define (operator exp) (car exp))
   (define (operands exp) (cdr exp))
;
; a. Explain what was done above.  Why can't we assimilate the predicates 
;    'number? and 'variable?' into the data directed dispatch? 
; ________________________________________________________________________
; This implementation keeps the same structure and the two base cases
;  but handles the operator->procedure mapping with the get operation
;  instead of conditionals. This would make it very easy to implement 
;  additional operators.
; The reason we cannot implement deriv for numbers (to replace the 
;  'numbers?' base case.) is at root that you would need a way to key by
;  "any number".
; This would could be circumvented by doing something like:
;   (define (type-tag exp)
;     (cond [(number? exp) 'number]
;           [(variable? exp) 'variable]
;           [else (operator exp)]))
;  but that is really just saying the same thing.
; The problem for 'variable?' is the same: cannot key by "all symbols".

; ________________________________________________________________________
; b. Write the procedures for derivatives of sums and products, and use 
;    the auxiliary code required to install them in the table used by the
;    program above.
; ________________________________________________________________________
(define (make-sum . a) (error "undefined"))

(define (install-deriv-package)
  ;; cannot use the old selectors since they target whole expressions 
  ;;  while the new deriv implementation omits the expression.
  (define (addend operands) (car operands))
  (define (augend operands) (cadr operands))

  (define (multiplier operands) (car operands))
  (define (multiplicand operands) (cadr operands))

  ;; derivative of a sum
  (define (deriv-sum operands var)
    (make-sum ;; This would need to be changed out aswell.
     (deriv (addend operands) var)
     (deriv (augend operands) var)))

  ;; derivative of a product
  (define (deriv-product operands var)
    (make-sum
     (make-product
      (multiplier operands)
      (deriv (multiplicand operands) var))
     (make-product
      (deriv (multiplier operands) var)
      (multiplicand operands))))

  (put 'deriv '+ deriv-sum)
  (put 'deriv '* deriv-product))
  
; ________________________________________________________________________
; c. Choose any additional differentiation rule that you like, such as 
;    the one for exponents (Exercise 2.56), and install it in this
;    data-directed system.
; ________________________________________________________________________

; We dont have this table system even implemented yet so im not bothering 
;  to make this valid but these interdependent constructors would need to
;  be rewritten and managed somehow.
(define (install-deriv-exponentiation)
  ;; new selectors again
  (define (base operands) (car operands))
  (define (exponent operands) (cadr operands))

  (define (deriv-expt operands var)
    (make-product
     (deriv (base operands) var)
     (make-product
      (exponent operands)
      (make-expt
       (base operands)
       (- (exponent operands) 1)))))

  (put 'deriv '** deriv-expt))


; ________________________________________________________________________
; d. In this simple algebraic manipulator the type of an expression is the
;    algebraic operator that binds it together.
;    Suppose, howeever, we indexed the procedures the opposite way, so 
;    that the dispatch line in 'deriv' looked like:
;       ((get (operator exp) 'deriv) (operands exp) var)
;    What corresponding changes to the derivative system are required?
; ________________________________________________________________________

; 'put' bodies would need to change the keys around but the bodies
;   would stay the same.


