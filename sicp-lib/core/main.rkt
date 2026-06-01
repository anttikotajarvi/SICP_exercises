#lang sicp

;; General exercise utilities; not from a specific SICP section.

(define (identity x)
  x)

(define (indent n)
  (make-string (* 2 n) #\space))

(define (print-seq . xs)
  (define (loop ys)
    (if (null? ys)
        (newline)
        (begin
          (display (car ys))
          (loop (cdr ys)))))
  (loop xs))

;; Debugging helpers for exercise output.
(define-syntax inspect
  (syntax-rules ()
    [(_ (f args ...))
     (let ([v (f args ...)])
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline))]
    [(_ expr)
     (let ([v expr])
       (write 'expr)
       (display " ; ")
       (write v)
       (newline))]))

;; rv = return value
(define-syntax inspect-rv
  (syntax-rules ()
    [(_ (f args ...))
     (let ([v (f args ...)])
       (write '(f args ...))
       (display " ; ")
       (write v)
       (newline)
       v)]
    [(_ expr)
     (let ([v expr])
       (write 'expr)
       (display " ; ")
       (write v)
       (newline)
       v)]))


;; SICP 2.3.1: Quotation.
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

;; SICP 1.3: Formulating Abstractions with Higher-Order Procedures.
(define (double f)
  (lambda (x) (f (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (iter result n)
    (if (<= n 1)
        result
        (iter (compose f result) (dec n))))
  (iter f n))

(#%provide identity
           indent
           print-seq
           inspect
           inspect-rv
           memq
           double
           compose
           repeated)
