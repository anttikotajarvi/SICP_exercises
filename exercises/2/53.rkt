; SICP 2.3.1
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Quotation
; Exercise 2.53:
; What should the interpreter print in response to evaluating
;  each of the following expressions?
; ______________________________________________________________
#lang sicp
(#%require "../lib.rkt")

(inspect (list 'a 'b 'c)) ; (a b c)
; This should evaluate the list of the symbols

(inspect (list (list 'george)))
; ((george))

(inspect (cdr '((x1 x2) (y1 y2)))) ; ((y1 y2))
(inspect (cadr '((x1 x2) (y1 y2)))) ; (y1 y2)
(inspect (pair? (car '(a short list)))) ; #f

(inspect (memq 'red '((red shoes) (blue socks)))) ; #f
; neither "(red shoes)" nor "(blue socks)" 'eq?' to red
(inspect (memq 'red '(red shoes blue socks))) ; (red shoes blue socks)