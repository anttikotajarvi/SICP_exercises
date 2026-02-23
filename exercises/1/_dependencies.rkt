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

