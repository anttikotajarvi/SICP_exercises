; 1. Building Abstractions with Procedures
; Exercise 1.16:
; Design a procedure that evolves an iterative exponentiation
;  process that uses successive squaring and uses a logarithmic 
;  number of steps, as does fast-expt.
; (Hint: Using the observation that (b^(n/2))^2 = (b^2)^(n/2), 
;  keep, along with the exponent 'n' and base 'b', an addittional 
;  state variable 'a', and define the state transformation in
;  such a way that the product ab^n is unchanged from state to
;  state. At the beginning of fthe process 'a' is taken to be 1,
;  and the answer is given by the value of 'a' at the end of the 
;  process. In general, the technique of defining an invariant
;  quantity that remains unchanged from state to state is a 
;  powerful way to think about the design of iterative
;  algorithms.)
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")

; The recursive approach
; b^n = ( b^(n/2) )^2   if n is even
; b^n = b * b^(n-1)     if n is odd 
(define (fast-expt-rec b n) 
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt-rec b (/ n 2))))
        (else (* b (fast-expt-rec b (- n 1))))))

(fast-expt-rec 2 10)
(fast-expt-rec 3 10)