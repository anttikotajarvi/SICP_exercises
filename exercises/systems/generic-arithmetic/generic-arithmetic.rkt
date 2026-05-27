#lang sicp

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (cosine x) (apply-generic 'cosine x))
(define (sine x) (apply-generic 'sine x))

(#%provide add sub mul div equ?)
