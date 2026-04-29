#lang sicp
(#%require "../lib.rkt")

(define (element-of-set? x set)
  (cond [(null? set) false]
        [(= x (entry set)) true]
        [(< x (entry set))
          (element-of-set? x (left-branch set))]
        [(> x (entry set))
          (element-of-set? x (right-branch set))]))

(define (adjoin-set x set)
  (cond [(null? set) (make-tree x '() '())]
        [(= x (entry set)) set]
        [(< x (entry set))
          (make-tree (entry set)
                     (adjoin-set x (left-branch set))
                     (right-branch set))]
        [(> x (entry set))
          (make-tree (entry set) (left-branch set)
                     (adjoin-set x (right-branch set)))]))
; ______________________________________________________________
; SICP 2.3.3
; Chapter: Building Abstractions with Data
; Section: Symbolic Data
  ; Subsection: Example: Representing Sets
; Exercise 2.63:
; Each of the following two procedures converts a binary tree to
;  a list.
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
                      (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                              (right-branch tree)
                              result-list)))))
  (copy-to-list tree '()))

; a. Do the two procedures produce the same result for every 
;    tree? If not, how do the results differ? What lists do the 
;    two procedures produce for the trees in Figure 2.16?
; ______________________________________________________________
(define (e entry) (make-tree entry '() '()))
(define tree1 
  (make-tree 7
            (make-tree 3 (e 1) (e 5))
            (make-tree 9 '() (e 11))))

(define tree2
  (make-tree 3 
             (e 1)
             (make-tree 7
                        (e 5) 
                        (make-tree 9 '() (e 11)))))

(define tree3 
  (make-tree 5 
             (make-tree 3 (e 1) '())
             (make-tree 9 (e 7) (e 11))))
(display "Procedure 1 : \n")
(inspect (tree->list-1 tree1)) ; (1 3 5 7 9 11)
(inspect (tree->list-1 tree2)) ; (1 3 5 7 9  11)
(inspect (tree->list-1 tree3)) ; (1 3 5 7 9 11)
(newline)
(display "Procedure 2 : \n")
(inspect (tree->list-2 tree1)) ; (1 3 5 7 9 11)
(inspect (tree->list-2 tree2)) ; (1 3 5 7 9 11)
(inspect (tree->list-2 tree3)) ; (1 3 5 7 9 11)

;; Both give out the same result.

;; Both give the result in the same order of:
;;     { f(left), entry, f(right) }
;; First implementation describes a classic tree recursive process:
;;     tree->list(tree)
;;     = {tree->list(left), entry, tree->list(right)}
;;
;;  The second also describes a tree recursive process but as an
;;   accumulator style procedure:
;;     copy-to-list(tree, result-list)
;;     =
;;     { copy-to-list(left,
;;         { entry, copy-to-list(right, result-list) }) 

; ______________________________________________________________
; b. Do the two procedures have the same order of growth in the 
;    number of steps required to convert a balanced tree with n
;    elements to a list?
;    If not, which one grows more slowly?
; ______________________________________________________________

;; Both procedures visit each tree node once, so the base traversal
;;  work is O(n), where n is the number of elements in the tree.
;;
;; The difference comes from the work done *at* each node.
;;
;; tree->list-2 uses cons to attach the current entry to the result.
;; cons is constant time, O(1). Since this happens once per node:
;;
;;   O(n * cons work) = O(n * 1) = O(n)
;;
;; tree->list-1 uses append to join the left-list with the current
;; entry and the right-list:
;;
;;   (append left-list
;;           (cons entry right-list))
;;
;; append is not constant time. It must walk through its first
;; argument, so its cost is:
;;
;;   O(length of left-list)
;;
;; In this procedure, left-list is the list produced from the 
;;  left subtree.  So each append costs as many steps as there
;;  are entries in that node's left subtree (which, in a 
;;  balanced tree, has half the entries.)
;;
;; For a balanced tree, the total append work at each level is
;;  O(n/2):
;;
;;    level 0: 1 node  * n/2  append work each = n/2
;;    level 1: 2 nodes * n/4  append work each = n/2
;;    level 2: 4 nodes * n/8  append work each = n/2
;;    level 3: 8 nodes * n/16 append work each = n/2
;;
;; A balanced tree has O(log n) levels, so the append work is:
;;
;;   O(n per level * log n levels) = O(n log n)
;;
;; Therefore:
;;
;;   tree->list-1 = O(n log n)
;;   tree->list-2 = O(n)
;;
;; So tree->list-2 grows more slowly.

; ______________________________________________________________
; Exercise 2.64:
; The following procedure 'list->tree' converts an ordered list
;  to a balanced binary tree.
; The helper procedure 'partial-tree' takes as arguents an 
;  integer n and a list and list of at least n elements and 
;  constructs a balanced tree containing the first n elements of
;  the of the list.  The result returned by 'partial-tree' is a 
;  pair (formed with cons) whose 'car' is the constructed tree
;  and whose 'cdr' is the list of elements not included in the
;  tree.
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let* ((left-size (quotient (- n 1) 2))

             (left-result (partial-tree elts left-size))
             (left-tree (car left-result))
             (non-left-elts (cdr left-result))

             (right-size (- n (+ left-size 1)))
             (this-entry (car non-left-elts))

             (right-result
              (partial-tree (cdr non-left-elts) right-size))
             (right-tree (car right-result))
             (remaining-elts (cdr right-result)))

        (cons (make-tree this-entry
                         left-tree
                         right-tree)
              remaining-elts))))
;            
; a. Write a short paragraph explaining as clearly as you can
;    how 'partial-tree' works.  Draw the tree produced by
;    (list->tree (list 1 3 5 7 9 11))
; ______________________________________________________________
(define t1 (list->tree (list 1 3 5 7 9 11)))
(print-tree t1)
;     5
;   /   \
; 1      9
;  \    / \ 
;   3  7   11

; ______________________________________________________________
; b. What is the order of growth in the number of steps required
;    by 'list->tree' to convert a list of n elements?
; ______________________________________________________________


; ______________________________________________________________
; Exercise 2.65:
; Use the results of Exercise 2.63 and 2.64 to give O(n) 
;  implementations of 'union-set' and 'intersection-set' for 
;  sets implemented as (balanced) binary trees.
; ______________________________________________________________
