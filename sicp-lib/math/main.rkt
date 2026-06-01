#lang sicp
(#%require sicp-lib/core)

;; General numeric helpers used throughout SICP exercises.
(define (pow base exp)
  (define (iter counter product)
    (if (= counter 0)
        product
        (iter (- counter 1) (* product base))))
  (iter exp 1))

(define (average . xs)
  (/ (apply + xs) (length xs)))

(define (log-base b)
  (lambda (x) (/ (log x) (log b))))

(define (square x)
  (* x x))

;; SICP 1.2.2: Tree Recursion.
;; Iterative Fibonacci procedure.
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

;; SICP 1.2.6: Example: Testing for Primality.
(define big-prime-1 1000000000039)
(define big-prime-2 1000000000000037)
(define big-prime-3 999999999999999023)
(define big-prime-4 9223372036854675811)

(define (expmod base exp m)
  (cond
    [(= exp 0) 1]
    [(even? exp) (remainder (square (expmod base (/ exp 2) m)) m)]
    [else (remainder (* base (expmod base (- exp 1) m)) m)]))

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond
    [(> (square test-divisor) n) n]
    [(divides? test-divisor n) test-divisor]
    [else (find-divisor n (+ test-divisor 1))]))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (and (>= n 2) (= n (smallest-divisor n))))

;; SICP 1.3.3: Procedures as General Methods.
;; From exercise 1.37.
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (dec i) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))

  (define (try guess)
    (let ([next (f guess)])
      (if (close-enough? guess next)
          next
          (try next))))

  (try first-guess))

;; SICP 1.3.4: Procedures as Returned Values.
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define dx 0.00001)
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))
(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(#%provide pow
           average
           log-base
           square
           fib
           big-prime-1
           big-prime-2
           big-prime-3
           big-prime-4
           expmod
           divides?
           find-divisor
           smallest-divisor
           prime?
           cont-frac
           fixed-point
           average-damp
           deriv
           newton-transform
           newtons-method)
