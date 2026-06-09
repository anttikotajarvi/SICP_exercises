; SICP 2.5.3
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Example: Symbolic Algebra
; Exercise 2.89: 
; Define procedures that implement the term-list representation
;  described above as approapriate for dense polynomials.
; ______________________________________________________________
; Exercise 2.90: 
; Suppose we want to have a polynomial system that is efficient 
;  for both sparse and dense polynomials.
; One way to do this is to allow both kinds of term-list 
;  representations in our system.
; The situation is analogous to the complex-number example of
;  Section 2.4, where we alloewd both rectangular and polar 
;  repreresentations.
; To do this we must distinguish different types of term list 
;  and make the operations on term lists generic.
; Redesign the polynomial system to implement this 
;  generalization.  This is a major effort, not a local change.
; ______________________________________________________________


; For term:
; x^5 + 2x^4 + 3x^2 - 2x - 5 or
; 1x^5 + 2x^4 + 0x^3 + 3x^2 - 2x^1 - 5x^0
;
; dense representation
; (1 2 0 3 -2 -5)
;
; sparse representaion
; ((5 1) (4 2) (2 3) (1 -2) (0 5))

;; Conclusion:
;; this is now somehow implemented in polynomial/terms but not 
;; very well, even the organization is bad.
;; The dense implementation ended up using the same term type 
;;  as the sparse one thus making the implementational differences
;;  very small (except 'adjoin-term' for dense is considerably 
;;  worse).  It feels as if Im missing the exact way the 2.89 
;;  exercise wants me to do it, thus making 2.90 very awkward 
;;  aswell.