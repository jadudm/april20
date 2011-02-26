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

(struct program (statements))
(struct assign (name value))
(struct binop (op lhs rhs))
(struct int (value))
(struct result (name))
