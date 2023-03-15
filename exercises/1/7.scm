; 1. Building Abstractions with Procedures
(load "_dependencies.scm")

; Exercise 1.7
; The ´good-enough?´ test used in computing
; square roots will not be very eﬀective for ﬁnding the square
; roots of very small numbers. Also, in real computers, arith-
; metic operations are almost always performed with lim-
; ited precision. this makes our test inadequate for very large
; numbers. Explain these statements, with examples showing
; how the test fails for small and large numbers. 
; An alternative strategy for implementing ´good-enough?´ is to watch
;  how guess changes from one iteration to the next and to
;  stop when the change is a very small fraction of the guess.
; Design a square-root procedure that uses this kind of end
;  test. Does this work better for small and large numbers?
;____________________________________________________________

; For small numbers, the predicate fails obviously when checking
;  the guess for the square root that is smaller than the magic number
;  specifying accuracy
; For example
    (good-enough? 0.0002 0.0002)
;=> true
; Guessing the square root of 0.0002 any number 
;  smaller than 0.02 returns true
; Implemented with the current ´sqrt-iter´ algorithm, it would not perform 
;  enough cycles for a sufficiently accurate result

;  correct answer to yield a positive result.
; For larger numbers, the guess needs to be exceedingly closer to the
; For example
    (define million 1000000)
    (good-enough? 999.9999995 million)
;=> false
    (define ten-billion 10000000000)
    (good-enough? 99999.999999995 ten-billion)
;=> false
; The guesses in both of the examples are the largest(*) ones
;  that result in false per their quotient
; You can observe the increasing decimal accuracy required to yield true
; When using the ´sqrt-iter´ implementation with the smaller numbers,
;  we werent doing enough cycles to achieve a accurate result, but
;  with these bigger numbers we would be doing increasingly more with bigger
;  the quotant.

; This all seems to stem from the ill-defined static 0.001 accuracy value
;  bringing us to the last part of the question

;"An alternative strategy for implementing ´good-enough?´ is to watch
;  how guess changes from one iteration to the next and to
;  stop when the change is a very small fraction of the guess.
; Design a square-root procedure that uses this kind of end
;  test. Does this work better for small and large numbers?"

; The simplest answer I cam up was:
(define (good-enough? guess x)
    (< (abs (- (square guess) x)) (/ guess 1000)))

(good-enough? 999.9999 million)
;=> true
(good-enough? 99999.9999 ten-billion)
;=> true
(good-enough? 0.0002 0.0002)
;=> false
