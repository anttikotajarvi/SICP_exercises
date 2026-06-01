; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.69:
; The following procedure takes as its argument a list of
;  symbol-frequency pairs (where no symbol appears in more than
;  one pair) and generates a Huffman encoding tree according to
;  the Huffman algorithm.
#lang sicp
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
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
(#%require sicp-lib)
(#%require sicp-lib/huffman)
(define pairs (list '(A 8) '(B 3) '(C 1) '(D 1) '(E 1) '(F 1) '(G 1) '(H 1)))

(define (successive-merge branches)
  (if (null? (cdr branches))
      (car branches) ; !!
      (let* ([s1 (car branches)]
             [s2 (cadr branches)]
             [rest (cddr branches)]
             [new (make-code-tree s1 s2)])
        (successive-merge (adjoin-leaf-set new rest)))))

  (#%provide generate-huffman-tree)

;(define tree (generate-huffman-tree pairs))
;(define msg '(B A D C A B))
;(define encoded (encode msg tree))
;(define decoded (decode encoded tree))
;
;(inspect pairs)
;(inspect tree)
;(inspect msg)
;(inspect encoded)
;(inspect decoded)
