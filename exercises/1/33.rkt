; 1. Building Abstractions with Procedures
; Exercise 1.33:
; You obtain even more general version of accumulate 
;  ([Exercise 1.31]) by introducing the notion of 'filter' on
;  the terms to be combined.  That is, combine only those terms
;  terms derived from values in the range that satisfy a 
;  specified condition .
; The resulting 'fitered-accumulate' abstraction takes the same
;  arguments as accumulate, together with an additional 
;  predicate of one argument that specifies the filter.
; Write 'filtered-accumulate' as a procedure.  Show how to 
;  express the following using 'filtered-accumulate':
; a. the sum of the squares of the prime numbers in the 
;     in the interval 'a to b' (assuming that you have a 
;     'prime?' predicate already written)
; b. the product of all the positive integers less than 'n' that
;     are relatively prime to 'n' (i.e., all positive integers 
;     'i < n' such that GCD(i, n) = 1).
; ______________________________________________________________

#lang sicp
(#%require "_dependencies.rkt")

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b) result
                (iter (next a)
                      [if (filter a) 
                          (combiner (term a) result)
                          result])))
  (iter a null-value))

(display "Sum of prime squares \n")
(inspect (filtered-accumulate prime? + 0 square 1 inc 5)); 2*2 + 3*3 + 5*5 = 38

(define (proc-b n)
  (define (no-common-factors? i)
    (= (gcd i n) 1))
  (filtered-accumulate no-common-factors? * 1 identity 1 inc (- n 1)))

(inspect (proc-b 10)) ; should be 1*3*7*9 = 189