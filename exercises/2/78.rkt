; SICP 2.5.1
; Chapter: Building Abstractions with Data
; Section: Systems with Generic Operations
; Subsection: Generic Arithmetic Operations
; Exercise 2.78:
; The internal procedures in the 'schem-number' package are essentially 
;  nothing more than calls to the primitive procedures +,-, etc.  It was 
;  not possible to use the primitives of the language directly because our 
;  type-tag system requires that eadch data object have a type attached to
;  it.  Infact, however, all Lisp implementations do have type system, 
;  which they use internally.  Primitive predicates such as 'symbol?' and 
;  'number?' determine whether data objects have particular types.  
; Modify the definitions of 'type-tag', 'conetents', and 'attach-tag' from
;  Section 2.4.2 so that our generic system takes advantage of Scheme's 
;  internal type system.  That is to say, the system should work as before 
;  except that ordinary numbers should be representeed simply as Scheme 
;  numbers rather than as pairs whose 'car' is the symbol 'scheme-number'.
; ________________________________________________________________________
#lang sicp
(define (type-tag datum)
  (cond [(number? datum) 'scheme-number]
        [else (car datum)]))

(define (contents datum)
  (cond [(number? datum) datum]
        [else (cdr datum)]))

(define (attach-tag type contents)
  (cond [(number? type) contents]
        [else (cons type contents)]))
