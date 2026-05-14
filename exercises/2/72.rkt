; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.72:
; Consider the encoding procedure that you designed in 
;  Exercise 2.68.  
; What is the order of growth in the number of steps needed to
;  encode a symbol?  Be sure to include the number of steps 
;  needed to search the symbol list at each node encountered.
; Consider the special case where the relative frequencies of 
;  the n symbols are as described in Exercise 2.71, and give the
;  order of growth (as a function of n) of the number of steps 
;  needed to encode the most frequent and least frequent symbols
;  in the alphabet. 
; ______________________________________________________________

;;   {A B C D E}
;;    /       \
;; A16      {B C D E}
;;           /      \
;;         B8      {C D E}
;;                  /    \
;;                C4    {D E}
;;                        / \
;;                      D2  E1


;; For the most frequent symbol the order of growth is just  
;; n + 1 or O(n)

;; For the most infrequent symbol (E in this case) have to iterate through a 
;;  n-level sized list for each level so:
;;  n + (n-1) + (n-2) + ... + 1
;; which is the triangular numbers pattern
;; so the same as:
;  n * (n+1) / 2
;; So the order of growth is: 
;; n(n+1)/2 
;; =(n^2 + n)/2
;; or just O(n^2)
#lang sicp