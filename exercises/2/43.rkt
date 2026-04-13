; SICP 2.2.3
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Sequences as Conventional Interfaces
; Exercise 2.43:
; Louis Reasoner is ahving a terrible time doing Exercise 2.42.
; His 'queens' procedure seems to work, but it runs extremely
;  slowly.  (Louis never does manage to wait long enough for it
;  to solve even the 6x6 case.)
; When louis asks Eva Lu Ator for help, she points out that he
;  has interchanged the order of the nested mappings in the
;  'flatmap', writing it as:
(flatmap (lambda (new-row)
           (map (lambda (rest-of-queens) (adjoin-position new-row k rest-of-queens))
                (queen-cols (- k 1))))
         (enumerate-interval 1 board-size))
; Explain why this interchange makes the program run slowly.
; Estimate how long it will take Louis's program to solve the
;  eight-queens puzzle, assuming that the program in
;  Exercise 2.42 solves the puzzle in time T.
; ______________________________________________________________

; 2.42 snippet:
(flatmap (lambda (rest-of-queens)
           (map (lambda (new-row) (adjoin-position new-row k rest-of-queens))
                (enumerate-interval 1 board-size)))
         (queen-cols (- k 1)))

;; Louis's implementation computes the previous queens for every new row 
;   instead of precomputing them.

; In the 2.42 version: the solutions for the first k - 1 columns are computed once,
;  then all the rows are considered.
; In Louis's version: the k - 1 columns are computed for each possible row:
; The work is repeated k - 1 times per level = k! = 8!

; therefore, if the first version completed in T-time, Louis's would take 8!T

