; SICP 2.4.3
; Chapter: Building Abstractions with Data
; Section: Multiple Representations for Abstract Data
; Subsection: Data-Directed Programming and Additivity
; Exercise 2.76:
; As a large system with generic operations evolves, new types 
;  of data objects or new operations may be needed.
; For each of the three strategies---generic operations with
;  explicit dispatch, data-directed style, and message-passing
;  style---describe changes that must be made to a system in
;  order to add new types or new operations. 
; ______________________________________________________________
#lang sicp
;; Explicit dispatch:
;; - Adding a new opertion: 
;;   "add new generic operation with explicit dispatch for all
;;    existing types"
;; - Adding a new type:
;;   "go over every generic operation and modify then to 
;;    recognize the new type"

;; Data-directed:
;; - Adding a new operation:
;;   "add the operation to every relevant type package where
;;    the entriy is inserted into the table"
;; - Adding a new type:
;;   "create a new package for the type and insert its operations
;;    in to the table"

;; Message-passing:
;; - Adding a new operation:
;;   "modify the existing constructor for all the types to handle
;;    the new operation"
;; - Adding a new type:
;;   "add a new constructor whose dispatch procedure handles
;;    relevant operations"

; ______________________________________________________________
; Which organization would be the most appropriate for a system
;  in which new types must often be added? 
; ______________________________________________________________
;; Data-directed seems like the best option, even though it 
;;  and message-passing seem to have the same implementation
;;  friction. Both are additive, but data-directed approach 
;,  seems to have the cleaner organization and semantics.

; ______________________________________________________________
; Which would be most appropriate for a system in which new 
;  operations must often be added?
; ______________________________________________________________
;; Since explicit dispatch groups the implementations by
;;  operations (each operation owns the dispatch over types) it 
;;  would make the most sense in theory.