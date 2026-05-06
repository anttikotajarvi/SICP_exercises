; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.68:
; The following procedure takes as its argument a list of
;  symbol-frequency pairs (where no symbol appears in more than
;  one pair) and generates a Huffman encoding tree according to
;  the Huffman algorithm.
#lang sicp
;(define (generate-huffman-tree pairs)
;  (successive-merge (make-leaf-set pairs)))
; 'make-leaf-set' is the procedure given above that transforms
;  the list of pairs into an ordered set of leaves.
; 'successive-merge' is the procedure you must write, using
;  'make-code-tree' to successively merge the smallest-weight
;  elements of the set until there is only one element left,
;  which is the desired Huffman tree.
; (This procedure is slightly tricky, but not really complicated.
;  if you find yourself designing a complex procedure, then you
;  are almost certainly doing something wrong.
;  You can take significant advantage of the fact that we are
;  using an ordered set representation.)
; ______________________________________________________________
(#%require "../lib.rkt")
(define pairs (list '(A 8) '(B 3) '(C 1) '(D 1) '(E 1) '(F 1) '(G 1) '(H 1)))
(define leaf-set (make-leaf-set pairs))

(define (merge-pairs pairs)
  (list (accumulate
          (lambda (a b)
            (cons (symbol-leaf a) b))
          '()
          pairs)
        (accumulate
          (lambda (a b) (+ (weight-leaf a) b))
          0
          pairs
          )))
(inspect pairs)
(inspect leaf-set)
(inspect (merge-pairs leaf-set))
(define (successive-merge pairs)
  (define (rec a w)
    ))