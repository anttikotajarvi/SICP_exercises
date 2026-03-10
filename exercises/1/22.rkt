; 1. Building Abstractions with Procedures
; Exercise 1.22:
; Most Lisp implementations include a primitive called 'runtime'
;  that returns an integer that specifies the amount of time the
;  system has been running (measured, for example, in 
;  microseconds).
; The following 'timed-prime-test' procedure, when called with
;  an integer n, prints n and checks to see if n is prime.
; If n is prime, the procedure prints three asterisks followed
;  by the amount of time used in performing the test.
#lang sicp
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
  (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

; Usinig this procedure, write a procedure 'search-for-primes'
;  that checks the primality of consecutive odd integers in a 
;  specified range.
; Use your procedure to find the three smallest primes larger
;  than 1000; larger than 10,000; larger than 100,000;
;  larger than 1,000,000.
; Note the time needed to test each prime.
; Since the testing algorithm as order of growth of O(sqrt(n)),
; You should expect the testing for primes around 10,000 should
;  take about sqrt(10) times as long as testing for primes
;  around 1000. Do your timing data bear this out?
; How well do the data for 100,000 and 1,000,000 support the
;  O(sqrt(n)) prediction? Is your result compatible with the
;  notion that programs on your machine run in time 
;  proportional to the number of steps required for the 
;  computation?
; ______________________________________________________________
(#%require "21.rkt")
(define (prime? n)
  (and (> n 1) (= n (smallest-divisor n))))

(define (search-for-primes start max)
  (define (iter num)
    (if (< num max)
      (cond ((even? num) (iter (+ num 1)))
      (else (begin
        (timed-prime-test num)
        (iter (+ num 2)))))))
  
  (iter start))

; This exercise is weird if im not understanding it wrong.
; We made the search-for-primes function but now we need to check 
;  the time for primes over large numbers: we dont need this 
;  function for it.

(timed-prime-test 1009)     ; 1009 *** 9
(timed-prime-test 100003)   ; 100003 *** 9
(timed-prime-test 1000003)  ; 1000003 *** 20

; The actual results vary too much to make any conclusion, 
;  these are just an example. 
; Mostly just measuring noise here so cannot say anything 
;  about the time complexity, except:
;   Usually the biggest one is slowest. 