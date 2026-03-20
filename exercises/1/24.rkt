; 1. Building Abstractions with Procedures
; Exercise 1.24:
; Modify the 'timed-prime-test' proceudure of [Exercise 1.22] to
;  to use 'fast-prime?' (the Ferma method), and test each of the 
;  12 primes found in that exercise.
; Since the Fermat test has O(log n) growth, how would you expect
;  the time to test primes near 1,000,000 to compare with the
;  time needed to test primes near 1000? Do your data bear this out?
; Can you explain any discrepancy you find?
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

; Fermat
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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

; Fast prime
(define (fast-prime? n times)
  (cond ((= times 0) true)
  ((fermat-test n) (fast-prime? n (- times 1)))
  (else false)))


; Timed prime
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10)
  (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(timed-prime-test 1009)      ; 5
(timed-prime-test 10009)     ; 8 
(timed-prime-test 100003)    ; 8
(timed-prime-test 1000003)   ; 12

; These test parameters were obviously designed
;  for slower computers so I really should bump
;  these numbers up, but when giving really big numbers 
;  the random functions breaks so I dont care.