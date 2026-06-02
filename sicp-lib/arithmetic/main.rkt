#lang sicp
;; SICP 2.5: Systems with Generic Operations.
(#%require sicp-lib/generic)

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
(define (arctangent y x) (apply-generic 'arctangent y x))

(define (square-root x) (apply-generic 'square-root x))

(define (negate x) (apply-generic 'negate x))

(#%provide add sub mul div square-g
           equ? =zero?
           cosine sine arctangent square-root)
