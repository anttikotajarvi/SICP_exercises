#lang sicp

;; Note that this implementation isn't finished
;;  and some stuff is broken, but since we haven't been
;;  given the implementation for 'put' and 'get', I think
;;  getting this to run is beside the point.

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (square-g x) (mul x x))

(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))

(define (cosine x) (apply-generic 'cosine x))
(define (sine x) (apply-generic 'sine x))
(define (arctangent x) (apply-generic 'arctangent x y))

(define (square-root x) (apply-generic 'square-root x))

(#%provide add sub mul div equ?
  cosine sine square-g square-root)
