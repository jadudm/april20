#lang racket/base
;; lang0
(provide (prefix-out lang0: (all-defined-out)))

;; Grammar
;; <program>   := (program (<assign> 1.. <result>))
;; <assign>    := (assign <name> <exp>)
;; <exp>       := (binop <op> <int> <int>)
;; <int>       := (int <number>)
;; <result>    := (result <name>)
;; <name>      := symbol?
;; <number>    := number?

(define-struct program (statements result))
(define-struct assign (name value))
(define-struct binop (op lhs rhs))
(define-struct int (value))
(define-struct result (name))
