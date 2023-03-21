; 1. Building Abstractions with Procedures
(load "_dependencies.scm")
; Exercise 1.11
; A function `f` is deﬁned by the rule that
; f(n) = { n if n < 3, 
;          f(n-1)+2f(n-2)+3f(n-3) if >= 3 }
; Write a procedure that computes f by means of a recursive
;  process. Write a procedure that computes f by means of an
;  iterative process.
;____________________________________________________________

; Recursive process (literal translation)
(define (f n) (if (< n 3) n 
    (+ (f (- n 1)) 
        (* 2 (f (- n 2)))
        (* 3 (f (- n 3)))) ))

; Iterative
 (define (f n) 
    (define (iter a b c count)
        (if (= count n)
            a
            (iter (+ a (* 2 b) (* 3 c)) a b (+ count 1) )))

    (if (< n 3)
        n 
        (iter 2 1 0 2)))
;                   ^ this offset gave me a headache


