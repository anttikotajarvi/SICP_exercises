; SICP 2.5.3
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Example: Symbolic Algebra
; Exercise 2.87: 
; Install '=zero?' for polynomials in the generic arithmetic 
;  package.  This will allow 'adjoin-zero' to work for 
;  polynomials with coefficients that are themselves polynomials.
; ______________________________________________________________

;; This required implementing:
;; =zero?-term
;; =zero?-termlist
;; and then just:
;;  (put '=zero? '(polynomial) (lambda (p)
;;    (=zero?-termlist (term-list p))))