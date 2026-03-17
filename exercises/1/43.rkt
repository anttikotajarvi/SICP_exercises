; 1. Building Abstractions with Procedures
; Exercise 1.43:
; If 'f' is numerical function and 'n' is a positive integer,
;  then we can form the n^th repeated application of f, which
;  is defined to be the function whose value at x is 
;  f(f(...(f(x))...)).  
; For example, if f is the function
;  x -> x + 1, the the n^th repeated application of f is the
;  function x |-> x + n.  If f is the operation of squaring a
;  number, then the n^th repeated application of f is the 
;  function that raises its argument to the 2^n-th power.
; Write a procedure that takes as inputs a procedure that 
;  computes 'f' and a positive integer 'n' and returns the 
;  procedure that computes the n^th repeated application of 'f'.
; Your procedure should be able to be used as follows:
;  ((repeated square 2) 5)
;  625
; Hint: You may find it convenient to use 'compose' from 
;  [Exercise 1.42].
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")
(define (repeated f n)
  (define (iter result n)
    (if (<= n 1)
        result
        (rec (compose f result) 
             (dec n))))
    (iter f n))

(inspect ((repeated square 2) 5))