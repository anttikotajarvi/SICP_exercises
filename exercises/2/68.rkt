; SICP 2.3.4
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
; Subsection: Example: Huffman Encoding Trees
; Exercise 2.68:
; The 'encode' procedure takes as arguments a message and a tree
;  and produces that list of bits that gives the encoded message.
#lang sicp
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
; 'encode-symbol' is a procedure, which you must write, that
;  returns the list of bits that encodes a given symbol
;  according to a given tree.
; You should design 'encode-symbol' so that it signals an error
;  if the symbol is not in the tree at all.
; Test your procedure by encoding the result you obtained in
;  Exercise 2.67 with the samplel tree and seeing whether it is
;  the same as the original sample message.
; ______________________________________________________________
(#%require "../lib.rkt")
;; 'symbols' returns a list of symbols for both a branch and a leaf!
(define (encode-symbol symbol tree)
  (cond [(not (element-of-set? symbol (symbols tree)))
         (error "Symbol not in tree: " symbol)]
        [(leaf? tree)
         '()]
        [(element-of-set? symbol (symbols (left-branch tree)))
         (cons 0
               (encode-symbol symbol (left-branch tree)))]
        [else
         (cons 1
               (encode-symbol symbol (right-branch tree)))]))

(define msg '(B A D C A B))
(define encoded (encode '(B A D C A B) A->C-sample-tree))
(define decoded (decode encoded A->C-sample-tree))
(inspect msg)
(inspect encoded)
(inspect decoded)

;; This was my initial solution before relizing that 'symbols' 
;;  returns a list of symbols for both a branch and a leaf...
(define (encode-symbol-2 symbol tree)
  (define (check-branch/leaf x)
    (if (leaf? x)
        (eq? symbol (symbol-leaf x))
        (element-of-set? symbol (symbols x))))

  (define (rec tree)
    (cond [(leaf? tree)
           (if (eq? symbol (symbol-leaf tree))
               '()
               (error "Symbol not in tree: " symbol))]
          [(check-branch/leaf (left-branch tree))
           (cons 0 (rec (left-branch tree)))]
          [(check-branch/leaf (right-branch tree))
           (cons 1 (rec (right-branch tree)))]))
  (rec tree))