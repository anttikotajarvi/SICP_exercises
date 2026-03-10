#lang sicp
; 1. Building Abstractions with Procedures
; Exercise 1.27:
; Demonstrate that the Carmichael numbers listed in 
;  [Footnote 1.47] really do fool the Fermat test.
; That is, write a procedure that takes an integer n and tests
;  whether a^n is congruent to 'a modulo n' for every 'a > n',
;  and try your procedure on the given Carmichale numbers.
; ______________________________________________________________

; i.e. ... write a procudere that tests wheter a^n % n = a % n

(#%require "_dependencies.rkt")
(define (fermat-congruence? a n)
  (= (expmod a n n) (remainder a n)))

(define (is-prime-or-carmichael? n)
  (define (iter a)
    (cond [(= a n) #t]                 ; checked 1..n-1
          [(fermat-congruence? a n) (iter (+ a 1))]
          [else #f]))
  (iter 1))


(is-prime-or-carmichael? 561)
(is-prime-or-carmichael? 1105)
(is-prime-or-carmichael? 1729)
(is-prime-or-carmichael? 2465)
(is-prime-or-carmichael? 2821)
(is-prime-or-carmichael? 6601)
