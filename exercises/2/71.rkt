; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.71:
; Suppose we have a Huffman tree for an alphabet of n symbols, 
;  and that the relative frequencies of the symbols are 1, 2, 3,
;  4, ..., 2^(n-1). 
; Sketch the tree for n = 5; for n = 10. 
; In such a tree (for general n) how many bits are required to
;  encode the most frequent symbol?  The least frequent symbol?
; ______________________________________________________________
#lang sicp
(#%require sicp-lib)
(#%require sicp-lib/huffman)
(#%require "69.rkt")


(define (gen-pairs n alphabet)
  (if (= n 0)
      '()
      (cons (list (car alphabet)
                  (expt 2 (- n 1)))
            (gen-pairs (- n 1)
                       (cdr alphabet)))))

(define alph '(A B C D E F G H I J))
(define p5 (gen-pairs 5 alph))
(define p10 (gen-pairs 10 alph))

(define tree5 (generate-huffman-tree p5))
(inspect (encode '(A) tree5)) ; (1)
(inspect (encode '(E) tree5)); (0 0 0)

(define tree10 (generate-huffman-tree p10))
(inspect (encode '(A) tree10)) ; (1)
(inspect (encode '(J) tree10)); (0 0 0 0 0 0 0 0 0)


;; Most frequent: 1 bit
;; Least frequent: n - 1 bits



