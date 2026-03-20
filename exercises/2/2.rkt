; SICP 2.1.2 
; Chapter: Building Abstractions with Data
; Section: Introduction to Data Abstraction
; Subsection: Abstraction Barriers
; Exercise 2.2:
; Consider the problem of representing line segments in a plane.
; Each segment is represented as a pair of points:
;  a starting point and an ending point.
; Define a constructor 'make-segment' and selectors 
;  'start-segment' and 'end-segment' that define the 
;  representation of of segments in terms of points.
; Furthermore, a point can be represented as a pair of numbers:
;  the x coordinate and the y coorinate.
; Accordingly, specify a constructor 'make-point' and selectors
;  'x-point' and 'y-point' that define this representation.
; Finally, using your selectors and constructors, define a 
;  procedure 'midpoint-segment' that takes a line segment as
;  argument and reurns its midpoint (the point whose coordinates
;  are the average of the coordinates of the endpoints).
; To try your procedures you'll need a way to print points:
#lang sicp
(define (print-point p)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))
; ______________________________________________________________

; Define:
; make-, start-, end-segment
; make-, x-, y-point
; midpoint-segment

(#%require "../lib.rkt")

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment p) (car p))
(define (end-segment p) (cdr p))

(define (midpoint-segment seg) 
  (make-point (average (x-point (start-segment seg))
                       (x-point (end-segment seg)))
              (average (y-point (start-segment seg))
                       (y-point (end-segment seg)))))

(define p1 (make-point 0 0))
(define p2 (make-point 1 1))
(define seg (make-segment p1 p2))

(#%provide make-point x-point y-point print-point)
(#%provide make-segment end-segment start-segment)