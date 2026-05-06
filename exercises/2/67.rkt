; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.67:
; Define an encoding tree and a sample message:
#lang sicp
(#%require "../lib.rkt")
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))
;
; Use the 'decode' procedure to decode the message, and give the 
;  result.
; ______________________________________________________________
(define msg (list 1 0 0 1 1 0 1 1 1 0 1 0))
(decode msg sample-tree) ; (B A D C A B)