; 1. Building Abstractions with Procedures

; Exercise 1.2 
; Translate the following expression into preﬁx form:
; 5 + 4 + (2 − (3 − (6 + 5/4 ))) / 3(6 − 2)(2 − 7)
;____________________________________________________________

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (*(* 3 (- 6 2)) (- 2 7))))
;=> -37/150
