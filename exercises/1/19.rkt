; 1. Building Abstractions with Procedures
; Exercise 1.19:
; There is a clever algorithm for computing the Fibonacci
;  numbers in a logarithmic number of steps. 
; Recall the transformation of the state variables 'a' and 'b'
;  in the 'fib-iter' process of [Section 1.2.2]: 
;  a <- a + b and b <- a.
; Call this transformation T, and observer that applying T over
;  and over again n times, starting with 1 and 0, produces the 
;  pair Fib(n + 1) and Fib(n). In other words, the Fibonacci 
;  numbers are produced by applying T^n, the n^th power of the
;  transformation T, starting with the pair (0, 1).
; Now consider T to be the special case of p = 0 and q = 1 in a
;  family of transformations T_pq, where T_pq transforms the pair
;  (a, b) according to 'a <- bq + aq + ap' and 'b <- bp + aq'.
; Show that if we apply such a transformation T_pq twice, the
;  effect is the same as using a single transformation T_p´q´
;  of the same form, and compute p` and q` in terms of p and q.
; This gives us an explicit way to square these transformations
;  and thus we can compute T^n using successive squaring, as
;  in the fast-expt procedure.
; Put this all together to complete the following procedure,
;  which runs in a logarithmic number of steps:
#lang sicp
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q)) ;compute p´ ; p´= p^2 + q^2 
                   (+ (* 2 p q) (* q q)) ;compute q´ ; q´= 2pq  + q^2
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
; ______________________________________________________________

; a <- bq + aq + ap
; b <- bp + aq

;; Showing that applying T_p,q twice  is the same as T_p´,q´ once
; given the rule:
; a´ = bq + aq + ap
; b´ = bp + aq

; (a_1, b_1) = T_p,q(a,b)
; so
; a_1 = bq + aq + ap 
;     = bq + a(q + p)
; b_1 = bp + aq

; applying it again (squaring)
; (a_2, b_2) = T_p,q(a_1, b1)
; so
; a_2 = b_1q + a_1q + a_1p
; b_2 = b_1p + a_1q

; Then substitue a_1 and b_1

; a_2 = b_1q + a_1q + a_1p
;     = b_1q + a_1(q + p)
; substitute
;     = (bpp + aq)q + (bq + a(q +p)(q + p))
;     = bpq + aq^2 + bq(q + p) + a(q + p)^2
;     = b(pq + q^2 + pq) + a(q^2 + (q + p)^2)
;     = b(2pq + q^2) + a(q^2 + q^2 + 2pq + p^2)
;     = b(2pq + q^2) + a(2q^2 + 2pq + p^2)


; b_2 = (bp + aq)p + (bq + a(q + p))q
;     = bp^2 + aqp + bq^2 + a(q + p)q
;     = b(p^2 + q^2) + a(qp + g^2 + pq)
;     = b(p^2 + q^2) + a(2pq + q^2)

; so:
; a_2 = b(2pq + q^2) + a(2q^2 + 2pq + p^2)
; b_2 = b(p^2 + q^2) + a(2pq + q^2)´
; which suggests
; p´= p^2 + q^2 
; q´= 2pq  + q^2

; so:
; a_2 = bq´ + a(p´ + q´) 
; b_2 = bp´ + aq´

; By definition
; a´ = bq´ = aq´ + ap´
;    = bq´+ a(q´ + p´)
; b´ = bp´ + aq´

; So 
; a_2 = a´
; b_2 = b´
; Thus, (a_2, b_2) = (a´, b´) for all inputs (a, b)

(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 1000000) ; millionth fibonacci number (in milliseconds to the terminal)