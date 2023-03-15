; 1. Building Abstractions with Procedures

; Exercise 1.5
; Ben Bitdiddle has invented a test to determine wheter the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedurs:
    (define (p) (p)) 
    (define (test x y)
        (if (= x 0) 0 y))
; Then he evaluates the expression
    (test 0 (p))
; What behavior will Ben observe with an interpreter that
; uses applicative-order evaluation? What behavior will he
; observe with an interpreter that uses normal-order evalu-
; ation? Explain your answer. 
; (Assume that the evaluation rule for the special form "if" is the same whether the in-
; terpreter is using normal or applicative order: The predi-
; cate expression is evaluated first, and the result determines
; whether to evaluate the consequent or the alternative expression.)
;____________________________________________________________


; This one is crazy compared to the previous ones

; (p) halts evaluation due to recursively calling itself

; applicative-order -> evaluate the arguments and then apply:
    (test 0 (p))
; On Lisp interpreter, halts before returning anything
; presumably because (p) is evaluated before it is applied to the (test) body
; Result: Program times out

; normal-order -> fully expand and then reduce
; Expansion
    (test 0 (p))
    (if (= 0 0) 0 (p))
; Reduction
    (if true 0 (p))
    0
; (p) is never evaluated
; Result: 0



