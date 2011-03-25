#lang racket/base
;; lang0
(provide (prefix-out lang2: (all-defined-out)))

;; Grammar
;; <program>   := (program (<constant> ...) <exp>)
;; <constant>  := (constant <name> <integer>)
;; <exp>       := (exp <op> <exp> <exp>)
;;              | <integer>
;; <name>      := symbol?
;; <integer>   := integer?

(struct program (constants expression))
(struct constant (name value))
(struct exp (op lhs rhs))
