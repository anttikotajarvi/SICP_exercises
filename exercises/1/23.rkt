; 1. Building Abstractions with Procedures
; Exercise 1.23:
; The 'smallest-divisor' procedure show at the start of this
;  section does lots of needless testing:
;  After it checks to see if the number is divisible by 2 there
;  is no point in checking to see if it is divisible by any 
;  larger even numbers.
; This suggests that the values used for 'test-divisor' should
;  not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ... .
; To implement this change, define a procedure 'next' that
;  returns 3 if its input is equal to 2 and otherwise returns
;  its input plus 2. Modify the 'smallest-divisor' procedure to
;  use (next test-divisor) instead of (+ test-divisor 1).
; With 'timed-prime-test' incorporating this modified version of
;  'smallest-divisor', run the test for each of the 12 primes 
;  found in [Exercise 1.22].
; Since this modification halves the number of test steps, you 
;  should expect it to run about twice as fast.
; Is this expectation confirmed? If not, what is the observed 
;  ratio of the speeds of the two algorithms, and how do you
;  explain the fact that it is different from 2?
; ______________________________________________________________
#lang sicp
(define (square n) (* n n))
(define (divides? a b) (= (remainder b a) 0))

; Old 
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
  (and (> n 1) (= n (smallest-divisor n))))

(define (smallest-divisor n) (find-divisor n 2))

; New
(define (next n) 
  (if (= n 2)
    3
    (+ n 2)))

(define (find-divisor-new n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor-new n (next test-divisor)))))

(define (smallest-divisor-new n) (find-divisor-new n 2))

(define (prime-new? n)
  (and (> n 1) (= n (smallest-divisor-new n))))


; Prime test as parameter
(define (timed-prime-test n p?)
  (newline)
  (display n)
  (start-prime-test n (runtime) p?))

(define (start-prime-test n start-time p?)
  (if (p? n)
  (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Timing
(define p1 1009)
(timed-prime-test p1 prime?)      ; 1009 *** 8
(timed-prime-test p1 prime-new?)  ; 1009 *** 2

(define p2 100003)
(timed-prime-test p2 prime?)      ; 100003 *** 4
(timed-prime-test p2 prime-new?)  ; 100003 *** 2

(define p3 1000003)
(timed-prime-test p3 prime?)      ; 1000003 *** 10
(timed-prime-test p3 prime-new?)  ; 1000003 *** 5

; The ratio is 2, it propably should be less but, again, 
;  the results are too smalls to conclude anything. 
; Not too interested in timing this stuff anyways.