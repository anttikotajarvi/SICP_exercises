; 1. Building Abstractions with Procedures
; Exercise 1.30:
; The sum procedure above generates a linear recursion.
; The procedure can be rewritten so that the sum is performed
;  iteratively. Show how to do this by filling in the missing
;  Expressions in the following definition:
; (define (sum term a next b)
;   (define (iter a result)
;     (if <??>
;         <??>
;         (iter <??> <??>)))
;   (iter <??> <??>))
; ______________________________________________________________
#lang sicp

; The linear recursive version
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

; The iterative version
(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) 
              (+ result
                 (term a)))))
            
  (iter a 0))

; Sum of integers 1..10 = 55
(define (identity x) x)
(sum-iter identity 1 inc 10)