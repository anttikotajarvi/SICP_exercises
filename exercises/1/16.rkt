; 1. Building Abstractions with Procedures
; Exercise 1.16:
; Design a procedure that evolves an iterative exponentiation
;  process that uses successive squaring and uses a logarithmic 
;  number of steps, as does fast-expt.
; (Hint: Using the observation that (b^(n/2))^2 = (b^2)^(n/2), 
;  keep, along with the exponent 'n' and base 'b', an additional 
;  state variable 'a', and define the state transformation in
;  such a way that the product ab^n is unchanged from state to
;  state. At the beginning of the process 'a' is taken to be 1,
;  and the answer is given by the value of 'a' at the end of the 
;  process. In general, the technique of defining an invariant
;  quantity that remains unchanged from state to state is a 
;  powerful way to think about the design of iterative
;  algorithms.)
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

; The recursive approach
; b^n = ( b^(n/2) )^2   if n is even
; b^n = b * b^(n-1)     if n is odd 
(define (fast-expt b n) 
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; For the iterative process:
; No change to math, just going to try adding an accumulator.
; Basically we just need to eliminate the deferred ops:
; square     for the even case
; * b        for the odd case

; the odd case multiplication is easy to shift to the accumulator.
; the even case might have been trickier if he book didnt 
;  give away the formula: (b^(n/2))^2 = (b^2)^(n/2)
(define (fast-expt-iterative b n)
  (define (iter b n a) 
    (cond ((= n 0) a)
          ((even? n) (iter (square b) (/ n 2) a))
          (else (iter b (- n 1) (* a b)))))
  (iter b n 1))
      

(fast-expt 4 7)
(fast-expt-iterative 4 7)

; ______________________________________________________________
; Notes

; (fast-expt 2 10) ; even^even
; (square (fast-expt 2  5))
; (square (* 2 (fast-expt 2 4)))
; (square (* 2 (square (fast-expt 2 2))))
; (square (* 2 (square (square (fast-expt 2 1)))))
; (square (* 2 (square (square (* 2 (fast-expt 2 0))))))
; (square (* 2 (square (square (* 2 1)))))
; (square (* 2 (square (square 2))))
; (square (* 2 (square 4)))
; (square (* 2 16))
; (square 32)
; 1024

; (fast-expt 3 4) ; odd^even
; (square (fast-expt 3 2)
; (square (square (fast-expt 3 1)))
; (square (square (* 3 (fast-expt 3 0))))
; (square (square (* 3 1)))
; (square (square 3))
; (square 9)
; 81

; (fast-expt 3 3) ; odd^odd
; (* 3 (fast-expt 3 2));
; (* 3 (square (fast-expt 3 1)))
; (* 3 (square (* 3 (fast-expt 3 0))))
; (* 3 (square (* 3 1)))
; (* 3 (square 3))
; (* 3 9)
; 27

;  even^odd
; (fast-expt 4 3)
; (* 4 (fast-expt 4 2))
; (* 4 (square (fast-expr 4 1)))
; (* 4 (square (* 4 (fast-expt 4 0))))
; (* 4 (square (* 4 1)))
; (* 4 (square 4))
; (* 4 16)
; 64
