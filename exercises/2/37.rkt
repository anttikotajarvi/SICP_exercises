; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.37:
; Suppose we represent vectors v = (v_i) as sequences of numbers,
;  and matrices m = (m_ij) as sequences of vectors (the rows of
;  the matrix).
; For example, the matrix
;  ( 1 2 3 4
;    4 5 6 6
;    6 7 8 9 )
;  is represented as the sequence:
;  ((1 2 3 4) (4 5 6 6) (6 7 8 9)).
; With this representation, we can use sequence operations to
;  concisely express the basic matrix and vector operations.
; These operations (which are described in any book on matrix
;  algebra) are the following:
;   (dot-product v w)
;   (matrix-*-vector m v)
;   (matrix-*-matrix m n)
;   (transpose m)
; We can define the dot product as
#lang sicp
(#%require "../lib.rkt")

(define (dot-product v w)
  (accumulate + 0 (map * v w)))
; Fill in the missing expressions in the following procedures
;  for computing the other matrix operations. (The procedure
;  'accumulate-n' is defined in Exercise 2.36.)
; ______________________________________________________________
(define (matrix-*-vector m v)
  (map (lambda (row) (accumulate + 0 (map * v row))) m))
(define swap (list (list 0 1) (list 1 0)))
(inspect (matrix-*-vector swap (list 1 2)))

(define (transpose m)
  (accumulate-n cons '() m))
(define m1 (list (list 1 2) (list 3 4) (list 5 6)))
(inspect (transpose m1))

(define (matrix-*-matrix m n)
  (let ([cols (transpose n)])
    (map (lambda (row)
           (map (lambda (col)

                  (dot-product row col))
                cols))
         m)))

(define id (matrix-*-matrix swap swap))
(inspect (matrix-*-matrix id m1))
