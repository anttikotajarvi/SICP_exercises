; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.51:
; Define the 'below' operation for painters.
; 'below' takes two painters as arguments.  The resulting
;  painter, given a frame, draws with the first painter in the
;  bottom of the frame and with the second painter in the top.
; Define 'below' in two different ways---first by writing a
;  procedure that is analogous to the 'beside' procedure given
;  above, and again in terms of 'beside' and suitable rotation
;  operations (from Exercise 2.50).
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../paint-util.rkt")
(#%require "../lib.rkt")
(define (above1 painter1 painter2)
  (let ([split-point (make-vect 0.0 0.5)])
    (let ([paint-bottom
           (transform-painter painter1 
              (make-vect 0.0 0.0) 
              (make-vect 1.0 0.0)
              split-point )]
          [paint-top
           (transform-painter painter2 
              split-point 
              (make-vect 1.0 0.5)
              (make-vect 0.0 1.0))])
      (lambda (frame)
        (paint-bottom frame)
        (paint-top frame)))))

(inspect (log-painter (above1 einstein einstein) "2-51-above1"))

(define (rotate90 painter)
  (transform-painter painter
    (make-vect 1 0)
    (make-vect 1 1)
    (make-vect 0 0)))

(define (rotate-270 painter)
  (transform-painter painter
    (make-vect 0 0)
    (make-vect 0 1)
    (make-vect 1 0)))
    
(define (above2 painter1 painter2)
  (define beside-painter (beside (rotate90 painter1) (rotate90 painter2)))
  (rotate270 beside-painter))
(inspect (log-painter (above2 einstein einstein) "2-51-above2"))