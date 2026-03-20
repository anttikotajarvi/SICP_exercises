; SICP 2.1.2 
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: Abstraction Barriers
; Exercise 2.3:
; Implement a representation for rectangles in a plane.
; (Hint: You may want to make use of [Exercise 2.2].)
; In terms of your constructors and selectors, create procedures
;  that compute the perimeter and the area of a given rectangle.
; Now implement a differet depresentation for rectangles.
; Can you design your system with suitable abstraction barriers,
;  so that the same perimeter and area procedures will work
;  using either representation?
; ______________________________________________________________ 
#lang sicp
(#%require "2.rkt")

; Minimal pair implementaion
; Make from opposite corner points: a and c

#|(define (make-rect a c) (cons a c))
(define a-rect car)
(define c-rect cdr)
(define (b-rect rect)
  (make-point (x-point (a-rect rect))
              (y-point (c-rect rect))))
(define (d-rect rect)
  (make-point (x-point (c-rect rect))
              (y-point (a-rect rect))))

(define (height-rect rect) 
  (abs (- (y-point (a-rect rect))
          (y-point (c-rect rect)))))

(define (width-rect rect) 
  (abs (- (x-point (a-rect rect))
          (x-point (c-rect rect)))))

(define rect (make-rect (make-point -1 -1) 
                         (make-point 1 1)))

 |#
;; Second implementation:
;; make from origin, width and height

; The make rect signature changes here but this is the first
;  thing i came up with
(define (make-rect a w h)
  (cons a (cons (abs w) (abs h)))) ;normalize w and h 

(define (width-rect rect) (car (cdr rect)))
(define (height-rect rect) (cdr (cdr rect)))
(define a-rect car) ; for compliance

(define rect (make-rect (make-point 0 0) 2 2))


; Procedures that use rectangles
(define (area-rect rect)
  (* (width-rect rect)
     (height-rect rect)))

(define (perimeter-rect rect)
  (+ (* 2 (width-rect rect))
     (* 2 (height-rect rect))))
                        
(#%require "../lib.rkt")
(inspect (a-rect rect))
(inspect (height-rect rect))
(inspect (width-rect rect))
(inspect (area-rect rect))
(inspect (perimeter-rect rect))