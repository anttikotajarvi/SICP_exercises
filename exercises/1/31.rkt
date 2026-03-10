; 1. Building Abstractions with Procedures
; Exercise 1.31:
; a. The 'sum' procedure is only the simplest of a vast number 
;  of similiar abstractions that can be captured as higher-order
;  procedures[^51].  Write an analogous procedure called 
;  'product' of the values of a function at points over a given
;  range,  Show how to define 'factorial' in terms of product.
; Also Use 'product' to compute approximiations to pi using the
;  formula[^52]
; pi/4 = 2 * 4 * 4 * 6 * 6 * 8 ...
;       __________________________
;       3 * 3 * 5 * 5 * 7 * 7 ...

; b. If your 'product' procedure generates a recursive process,
;  write on that generates an iterative process.
; If it generates an iterative process, write one that generates
;  a recursive process.
; ______________________________________________________________
#lang sicp
(#%require "_dependencies.rkt")


(define (identity x) x)

; Recursive
(define (product-rec f a b)
  (if (> a b) ; a to b inclusive
    1
    (* (f a)
       (product-rec f (inc a) b))))
      
(define (factorial-rec n) 
(product-rec identity 1 n))
(factorial-rec 1)
(factorial-rec 4)


; Iterative
(define (product-iter f a b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (inc a) 
              (* (f a)
                  result))))
  (iter a 1))

(define (factorial-iter n)
  (product-iter identity 1 n))

(factorial-iter 1)
(factorial-iter 4)

; First instinct was to make two terms for the numerator and 
;  denominator but the divide operations would be too big so
;  we rearrange the term to:
;  (2*4)/(3*3) * (4*6)/(5*5) * (6*8)/(7*7)
; or
; 2n(2n + 2)
; __________
; (2n + 1)^2 
(define (pi-approx N)
  (define (term n)
    (let ((two-n (* 2.0 n)))
      (/ (* two-n (+ two-n 2))
        (square (+ two-n 1)))))
  
  (* 4 (product-iter term 1 N)))

(pi-approx 100)
; ______________________________________________________________
; [^51]: The intent of [Exercise 1.31] through [Exercise 1.33] 
;  is to demonstrate the expressive power that is attained by 
;  using an appropriate abstraction to consolidate many 
;  seemingly disparate operations.  However, though accumulation
;  and filtering are elegant ideas, our hands are somewhat tied
;  in using them at this point since we do not yet have data
;  structures to provide suitable means of combination for 
;  these abstractions.
; We will return to these ideas in [Section 2.2.3] when we show
;  how to use sequences as interfaces for combining filters and
;  accumulators to build even more powerful abstractions.
; We will see there how these methods really come into their own
;  as a powerful and elegant approach to designing programs.

; [^52]: This formula was discovered by the seventeenth-century
;  English mathematician John Wallis.
