#lang sicp
; 1. Building Abstractions with Procedures
; Exercise 1.25:
; Alyssa P. Hacker complains that we went to a lot of extra work
;  in writing 'expmod'. After all, she says, since we already
;  know how to compute exponentials we could have simply written
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
  
; Is she correct? Would this procedure serve as well for our
;  prime tester? Explain.
; ______________________________________________________________
(#%require "_dependencies.rkt")

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

; Fast prime
(define (fast-prime? n times)
  (cond ((= times 0) true)
  ((fermat-test n) (fast-prime? n (- times 1)))
  (else false)))

(define (fast-expt b n) 
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

; It seems to work for up to (atleast) 100003 but 
;  at 1000003 is very slow.
(fast-prime? 1000003 1)

; So looking at the expmod implementation from the book:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
          (remainder 
            (square (expmod base (/ exp 2) m))
            m))
        (else 
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

; The main difference seems to be that the "correct" version reduces
;  the modulo after every square, while Alyssa's version only does
;  it at the very end; this building a massive number in memory 
;  and then tries to multiply it.
; Both are mathematically correct though.