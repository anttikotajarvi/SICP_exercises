; SICP 2.5.3
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Example: Symbolic Algebra
; Exercise 2.88: 
; Extend the polynomial system to include subtraction of 
;  polynomials. (Hint: You may find it helpful to define a 
;  generic negation operation.)
; ______________________________________________________________

;; Even with the data-driven system, adding operations is still
;;  painful.

;; The hint is actually very helpful.
;; The add-terms function already does the ordered list walk
;;  and since 
;;    p1 - p2 is the same as p1 + (- p2) 
;;  our implementation boils down to:
;;   (define (sub-terms L1 L2) (add-terms L1 (negate-termlist L2)))

;; after implementing the generic negation operation