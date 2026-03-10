#lang sicp

; Iterative fibonnaci procedure
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(#%provide fib)


(define (indent n) (make-string (* 2 n) #\space))
(#%provide indent)


(define (print-seq . xs)
  (define (loop ys)
    (if (null? ys)
        (newline)
        (begin
          (display (car ys))
          (loop (cdr ys)))))
  (loop xs))
(#%provide print-seq)

(define (square x) (* x x))
(#%provide square)

(define big-prime-1 1000000000039)
(define big-prime-2 1000000000000037)
(define big-prime-3 999999999999999023)
(define big-prime-4 9223372036854675811)
(#%provide big-prime-1)
(#%provide big-prime-2)
(#%provide big-prime-3)
(#%provide big-prime-4)


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
(#%provide expmod)


(define (identity x) x)
(#%provide identity)

; This is nutty but cool
(define-syntax inspect
  (syntax-rules ()
    ((_ (f args ...))
     (let ((v (f args ...)))
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline)
      ))
    ((_ expr)
     (let ((v expr))
       (write 'expr)
       (display " ; ")
       (write v)
       (newline)))))

; rv = return value
(define-syntax inspect-rv
  (syntax-rules ()
    ((_ (f args ...))
     (let ((v (f args ...)))
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline)
       v))
    ((_ expr)
     (let ((v expr))
       (write 'expr)
       (display " ; ")
       (write v)
       (newline)
       v))))
(#%provide inspect inspect-rv)

(define (divides? a b)
  (= (remainder b a) 0))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (prime? n)
  (and (>= n 2)
       (= n (smallest-divisor n))))
(#%provide divides? find-divisor smallest-divisor prime?)

;; From 1.37
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0) 
        result
        (iter (dec i)
              (/ (n i) 
                 (+ (d i) result)))))
  (iter k 0))
(#%provide cont-frac)