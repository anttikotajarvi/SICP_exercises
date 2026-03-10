#lang sicp
; 1. Building Abstractions with Procedures
; Exercise 1.28:
; One variant of the Fermat test that cannot be fooled is
;  called the Miller-Rabin test (Miller 1976; Rabin 1980).
; This starts from an alternate form of Fermat's Little
;  Theorem, which states that if 'n' is a prime number
;  and 'a' is any positive integer less than 'n', then 'a'
;  raised to the (n-1)-st power is congruent to 1 modulo 'n'.
; To test the primality of a number 'n' by the Miller-Rabin
;  test, we pick a random number 'a < n' and raise 'a' to the
;  (n - 1)-st power modulo 'n' using the expmod procedure.
; However, whenever we perform the squaring step in expmod,
;  we check to see if we have discovered a "nontrivial square
;  root of 1 modulo n", that is, a number not equal to 1 or n-1
;  whose square is equal to 1 modulo n.
; It is possible to prove that if such a nontrivial square root
;  exists, then 'n' is not prime.
; It is also possible to prove that if 'n' is an odd number that
;  that is not prime, then, for at least half the numbers a < n,
;  computing a^(n-1) in this way will reveal a nontrivial square
;  root of 1 modulo n.
; (This is why the Miller-Rabin test cannot be fooled.)
; Modify the expmod procedure to signal if it discovers a 
;  nontrivial square root of 1, and use this to implement the 
;  Miller-Rabin test with a procedure analogous to 'fermat-test'.
; Check your procedure by testing various known primes and
;  non-primes.
; Hint: One convenient way to make expmod signal is to have it
;  return 0. 
; ______________________________________________________________

(#%require "_dependencies.rkt")

; Alternate form of Fermat's Little Theorem
; "if n is prime, and n > a > 0
;  then  a^(n-1) % n = 1"
; Then to test primality of number 'n' by the MR test:
; - random number a, 1 < a < n
; - compute a^(n-1) % n

; "square root of modulo n"
; x^2 mod n = 1
; Trivial ones would be:
;  x = 1
;  x = n - 1
;  x^2 mod n = 1

; So if we find nontrivial square root of 1 moudlo n, we know n
;  is composite.
(define (nontrivial-sqrt-1? x n)
  (and (not (= 1))
       (not (x = (- n 1)))
       (= (remainder (square x) n) 1))) 


; Regular expmod for reference
(define (expmod base exp n)
  (cond ((= exp 0) 1)
        ((even? exp)
          (let ((x (expmod base (/ exp 2) n)))
            (cond ((= x 0) 0) ; propagate signal
            ((nontrivial-sqrt-1? x n) 0)
            (else (remainder (square x) n)))))
        (else 
          (let ((x (expmod base (- exp 1) n)))
            (if (= x 0)
                 0
                 (remainder (* base x) n))))))

; Only now looked up the square bracket syntax;
;  it was getting pretty unbearable to write without it.
(define (miller-rabin n tries)
  (define (random-a)
    ; [1 .. n-1] to avoid trivial cases
    (random (- n 1)))

  (define (trial)
    (= (expmod (random-a) (- n 1) n) 1))

  (define (iter k)
    (cond [(= k 0) #t]
          [(trial) (iter (- k 1))]
          [else #f]))

  ;; Added these base conditions to keep the random
  ;;  op from being fed numbers < 1
  (cond 
    [(< n 2) #f]
    [(or (= n 2) (= n 3)) #t]
    [(even? n) #f]
    [else (iter tries)]))
(#%provide miller-rabin)

(display "Should be #t (prime) \n")
(miller-rabin 2 10)
(miller-rabin 3 10)
(miller-rabin 97 10)
(miller-rabin 1009 10)
(miller-rabin 1000003 10)

(display "Should be #f (composite) \n")
(miller-rabin 1 10)
(miller-rabin 9 10)
(miller-rabin 21 10)
(miller-rabin 341 10)
(miller-rabin 561 10)   ; Carmichael: 3*11*17