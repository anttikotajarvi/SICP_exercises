; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.37:
; Suppose we represent vectors v = (v_i) as sequences of numbers,
;  and matrices m = (m_ij) as sequences of vectors (the rows of 
;  the matrix).
; For example, the matrix
;  ( 1 2 3 4
;    4 5 6 6
;    6 7 8 9 )
;  is represented as the sequence:
;  ((1 2 3 4) (4 5 6 6) (6 7 8 9)).
; With this representation, we can use sequence operations to 
;  concisely express the basic matrix and vector operations.
; These operations (which are described in any book on matrix
;  algebra) are the following:
; (dot-product v w)   returns the sum