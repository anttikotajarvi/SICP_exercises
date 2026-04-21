; SICP 2.3.1
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Quotation
; Exercise 2.55:
; Eva Lu Ator types to the interpreter the expression
;   (car ''abracadabra)
; To her surprise, the interpreter prints back 'quote'. Explain.
; ______________________________________________________________

#lang sicp
(car ''abracadabra)
; This should be the same as
(car (quote (quote abracadabra)))
; Which is the same as
(car (list 'quote (list 'quote 'abracadabra)))
; Which makes sense. 
