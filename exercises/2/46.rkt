; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.46:
; A two-dimensional vector v running from the origin to a point
;  can be represented as a pair consisting of an x-coordinate
;  and a y-coordinate.
; Implement a data abstraction for vectors by giving a
;  constructor 'make-vect' and corresponding selectors
;  'xcor-vect' and 'ycor-vect'.
; In terms of your selectors and constructor, implement
;  procedures 'add-vect', 'sub-vect', and 'scale-vect' that
;  perform the operations of vector addition, subtraction and
;  multiplying a vector by a scalar:
;  (x1, y1) + (x2, y2) = (x1 + x2, y1 + y2),
;  (x1, y1) - (x2, y2) = (x1 - x2, y1 - y2),
;  s * (x, y) = (sx, sy)
; ______________________________________________________________
#lang sicp
(define (make-vect x y)
  (cons x y))
(define (xcor-vect v)
  (car v))
(define (ycor-vect v)
  (cdr v))

(define (vector-component-op op)
  (lambda (v1 v2) 
    (make-vect 
      (op (xcor-vect v1) (xcor-vect v2)) 
      (op (ycor-vect v1) (ycor-vect v2)))))

(define add-vect (vector-component-op +))
(define sub-vect (vector-component-op -))

(define (scale-vect s v)
  (make-vect 
    (* s (xcor-vect v))
    (* s (ycor-vect v))))

(define v1 (make-vect 1 2))
(define v2 (make-vect 3 4))
(#%require "../lib.rkt")
(inspect (add-vect v1 v2))
(inspect (sub-vect v1 v2))
(inspect (scale-vect 2 v1))


