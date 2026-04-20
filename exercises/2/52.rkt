; SICP 2.2.4
; Chapter: Building Abstractions with Data
; Section: Hierarchical Data and the Closure Property
; Subsection: Example: A Picture Language
; Exercise 2.52:
; Make changes to the square limit of 'wave' shown in Figure 2.9
;  by working at each of the levels described above.
; In particular:
; a. Add some segments to the primitive 'wave-painter' of
;    Exercise 2.49 (to add a smile, for example).
; b. Change the pattern constructed by 'corner-split' (for
;    example, by using only one copy of the 'up-split' and 
;    'right-split' images instead of two).
; ______________________________________________________________
#lang sicp
(#%require sicp-pict)
(#%require "../paint-util.rkt")
(#%require "../lib.rkt")
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ([up (up-split painter (- n 1))]
            [right (right-split painter (- n 1))])
        (let ([top-left (beside up up)]
              [bottom-right (below right right)]
              [corner (corner-split painter (- n 1))])
          (beside (below painter top-left) 
                  (below bottom-right corner))))))

