; SICP 2.5.3
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Example: Symbolic Algebra
; Exercise 2.89: 
; Define procedures that implement the term-list representation
;  described above as approapriate for dense polynomials.
; ______________________________________________________________
;; For terms:
;; x^5 + 2x^4 + 3x^2 - 2x - 5 or
;; 1x^5 + 2x^4 + 0x^3 + 3x^2 - 2x^1 - 5x^0

;; dense representation
;, (1 2 0 3 -2 -5)

;; sparse representaion
;; ((5 1) (4 2) (2 3) (1 -2) (0 5))


